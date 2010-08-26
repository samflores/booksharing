class Setup
  def self.connection
    @@connection
  end
  
  def self.database
    @@connection.connection
  end
  
  def self.connect_to_database!(filename='config/database.yml')
    config = YAML.load(File.read(filename))
    @@connection = ActiveRecord::Base.establish_connection config[ENV['RACK_ENV']]
  end
  
  def self.create_tables!
    migration = ActiveRecord::Migration
    verbose, migration.verbose = migration.verbose, ENV['RACK_ENV'] != 'test'
    load_schema
    migration.class_eval do
      @@schema.each_pair do |klass, columns|
        table_name = const_get(klass).table_name rescue klass
        unless table_exists?(table_name)
          create_table(table_name, klass =~ /^[a-z]/ ? {:id => false} : {}) do |t|
            t.timestamps
          end
        end
        table_columns = columns(table_name).map(&:name)
        columns.each_pair do |name, info|
          unless table_columns.include?(name.to_s)
            add_column(table_name, name, info['type'], info.except('type'))
          end
        end
      end
    end
    migration.verbose = verbose
  end
  
  def self.boot!
    connect_to_database!
    create_tables!
  end

  private
  def self.load_schema
    @@schema ||= YAML.load(File.read('db/schema.yml'))
  end
end

Setup.boot!