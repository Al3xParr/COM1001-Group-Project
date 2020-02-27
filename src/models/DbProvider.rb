# DbProvider.rb
# date      27/02/2020
# author    Luke Suckling

require "sequel"

class DbProvider

    def initialize(tableName = nil)

        @db = Sequel.sqlite('../database/bookmarksDatabase.db')

        if tableName != nil then
            return getTable(tableName)
        end

    end

    def getTable(tableName)

        if @db[tableName] != nil then
            return @db[tableName]
        else
            raise "The requested table doesn't exist."
        end
    end

    def getDatabase()

        return @db

    end
end