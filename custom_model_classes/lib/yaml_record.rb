class YamlRecord
  # Every YamlRecord model is required to set it's attributes manually, with this accessor. See line 2 in
  # the Post model in app/models.
  cattr_accessor :attributes
  
  def initialize(params = nil, new_record = true)
    @params = params || default_params
    @new_record = new_record
    define_getters_and_setters
  end
  
  # Used by form_for to determine if it should point to the create or the update action.
  def new_record?
    @new_record || false
  end
  
  # url_for (which is what link_to uses to generate urls) calls to_param in order to determine
  # the url when you do url_for(some_instance) (rather than url_for(some_instance.id))
  def to_param
    id
  end
  
  def save
    # Add an id to the params hash
    assign_primary_key!
    
    # Merge the new data into the existing data.
    new_data = self.class.data << @params
    
    # Inject the new data into the YAML file.
    File.open(self.class.path_to_data, 'w' ) { |out| YAML.dump(new_data, out) }
    
    # No longer a new record
    @new_record = false
    
    # Everything succeeded, return true.
    true
  end
  
  def update_attributes(params)
    # Remove the old record
    self.class.data.delete_if {|d| d['id'] == id }
        
    # Add the new, updated record
    self.class.data << params.merge('id' => id)
    
    # Inject the updated data into the YAML file.
    File.open(self.class.path_to_data, 'w' ) { |out| YAML.dump(self.class.data, out) }
    
    # Everything succeeded, return true
    true
  end
  
  def id
    @params['id']
  end
  
  # Pass :all or 1 or "1" to find a record.
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
  
  # An array of instances.
  def self.find_all
    data.map {|result| new(result, nil) }
  end
  
  # Returns an instance or, nil if nothing was found
  def self.find_one(id)
    result = data.find {|d| d['id'] == id.to_i }
    result ? new(result, nil) : nil
  end
  
  # Defines the accessor methods for the data.
  def define_getters_and_setters
    self.class.attributes.each do |attribute|
      define_method(attribute) { @params[attribute] }
      define_method("#{attribute}=") {|value| @params[attribute] = value }
    end
  end
  
  # When new is called without any parameters, we have to set the defaults. If the attributes are
  # 'title' and 'body', it will return {'title' => '', 'body' => ''}.
  def default_params
    self.class.attributes.inject({}) {|hash, attribute| hash.merge(attribute => "") }
  end
  
  # Returns the parameters with a newly assigned auto incremented id (used for record creation).
  def assign_primary_key!
    @params.merge!(:id => self.class.data.size + 1)
  end

  # Loads the YAML file as a hash
  def self.data
    @data ||= YAML.load_file(path_to_data)
  end
  
  def self.path_to_data
    File.join(Rails.root, 'db', "#{self.to_s.tableize}.yml")
  end
end