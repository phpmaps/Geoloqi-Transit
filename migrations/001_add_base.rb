Sequel.migration do
  up {
    DB.create_table :agencies do
      primary_key :id
      String      :name
      String      :real_name
      String      :url
      String      :time_zone

      Time        :date_created
      Time        :date_modified
      Boolean     :is_deleted,   default: false
    end

    DB.create_table :stops do
      Integer     :agency_id
      Integer     :uid
      String      :name
      String      :desc
      String      :lat
      String      :lng

      Time        :date_created
      Time        :date_modified
      Boolean     :is_deleted,    default: false

      index       :agency_id
      index       :uid
    end

    DB.create_table :stop_times do
      Integer     :agency_id
      Integer     :stop_id
      Integer     :trip_id
      add_column  :arrival_time, type: 'time'
      #Time        :arrival_time, only_time: true
      Boolean     :next_day,     default: false
      Time        :date_created
      Time        :date_modified
      Boolean     :is_deleted,   default: false

      index       :agency_id
      index       :stop_id
      index       :trip_id
    end

    DB.create_table :trips do
      Integer     :agency_id
      Integer     :uid
      Integer     :route_id
      Integer     :service_id
      String      :direction

      Time        :date_created
      Time        :date_modified
      Boolean     :is_deleted,    default: false

      index       :agency_id
      index       :uid
      index       :route_id
      index       :service_id
    end

    DB.create_table :routes do
      Integer     :agency_id
      Integer     :uid
      String      :name
      String      :short_name

      Time        :date_created
      Time        :date_modified
      Boolean     :is_deleted,    default: false

      index       :agency_id
      index       :uid
    end

# This is connected to calendars.txt, it shows when routes will be open.. or something

    DB.create_table :services do
      String :uid, primary_key: true
      Boolean :monday
      Boolean :tuesday
      Boolean :wednesday
      Boolean :thursday
      Boolean :friday
      Boolean :saturday
      Boolean :sunday
      column :start_date, 'date'
      column :end_date,   'date'
      index :uid
    end

  }

  down {
    DB.drop_table :agencies
    DB.drop_table :stops
    DB.drop_table :stop_times
    DB.drop_table :trips
    DB.drop_table :routes
    DB.drop_table :services
  }
end
