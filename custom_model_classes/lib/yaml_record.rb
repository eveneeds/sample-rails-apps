class YamlRecord
  cattr_accessor :attributes
  
  def initialize(params = nil, new_record = true)
    @params = params || empty_params
    @new_record = new_record
    define_getters_and_setters
  end
  
  # Used by form_for to determine if it should point to the create or the update action.
  def new_record?
    @new_record || false
  end
  
  # Used with url_for (which is what link_to uses to generate urls) to determine the parameter
  # to assume params[:id] points to.
  def to_param
    id
  end
  
  def save
    # Add an id to the params hash
    add_id_to_params
    
    # Generate an array with the old data and the new data.
    new_data = self.class.data << @params
    
    # Inject the new data into the YAML file.
    File.open(self.class.path_to_data, 'w' ) { |out| YAML.dump(new_data, out) }
    
    # No longer a new record
    @new_record = false
    
    # Everything succeeded, return true.
    true
  end
  
  def update_attributes(params)
    # Remove the old record from the data
    self.class.data.delete_if {|d| d['id'] == id }
        
    # Re-add the updated data
    self.class.data << params.merge('id' => id)
    
    # Inject the new data into the YAML file.
    File.open(self.class.path_to_data, 'w' ) { |out| YAML.dump(self.class.data, out) }
    
    # Everything succeeded, return true
    true
  end
  
  # Defining the ID method, if not we'll get Ruby's object_id.
  def id
    @params['id']
  end
  
  def self.find(parameter)
    case parameter
    when :all
      find_all
    when String, Integer
      find_one(parameter)
    else
      raise "Invalid parameter given to find (#{parameter})"
    end
  end
  
  private
  
  def define_getters_and_setters
    self.class.attributes.each do |attribute|
      define_method(attribute) { @params[attribute] }
      define_method("#{attribute}=") {|value| @params[attribute] = value }
    end
  end
  
  # When new is called without any parameters, we have to set the defaults. If the attributes are
  # 'title' and 'body', it will return {'title' => '', 'body' => ''}.
  def empty_params
    self.class.attributes.inject({}) {|hash, attribute| hash.merge(attribute => "") }
  end
  
  # Returns the parameters with a newly assigned id to it (used for record creation)
  def add_id_to_params
    @params.merge!(:id => self.class.data.size + 1)
  end
  
  # Create one instance of the model per record in the YAML file.
  def self.find_all
    data.map {|result| new(result, nil) }
  end
  
  # Creates one instance of the model for the record representing the passed id (or nil if nothing
  # was found)
  def self.find_one(id)
    result = data.find {|d| d['id'] == id.to_i }
    result ? new(result, nil) : nil
  end

  # Gets the data as a hash.
  def self.data
    @data ||= YAML.load_file(path_to_data)
  end
  
  def self.path_to_data
    @path_to_data ||= File.join(Rails.root, 'db', "#{self.to_s.tableize}.yml")
  end
  
  # Creates a instance with @new_record as nil.
  def self.new_as_existing_record(params)
    instance = new(params)
    instance.instance_eval { @new_record = nil }
    instance
  end
end