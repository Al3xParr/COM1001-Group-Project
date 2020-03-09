# DbProvider.rb
# date      27/02/2020
# author    Luke Suckling

require "sequel"

class DbProvider

    DB = Sequel.sqlite('../database/bookmarksDatabase.db')

    def self.getTable(tableName)

        if DB[tableName] != nil then
            return DB[tableName]
        else
            raise "The requested table doesn't exist."
        end
    end

    def self.getDatabase()

        return DB

    end
end