#BookmarkReport_test.rb
#Ramona Petre

require 'minitest/autorun'
require 'sqlite3'
require 'securerandom'
require_relative '../models/Bookmark'
require_relative '../models/BookmarkReport'

class BookmarkReportTests < Minitest::Test
    def setup
        
        db = SQLite3::Database.new 'database.db'
        
        db.execute "DELETE FROM bookmark_reports"
        
        db.execute "INSERT INTO bookmark_reports(bookmarkId, userId, issue, description) VALUES('1', '1', 'something', 'report');"
        db.execute "INSERT INTO bookmark_reports(bookmarkId, userId, issue, description) VALUES('1', '2', 'report', 'not working');"
        db.execute "INSERT INTO bookmark_reports(bookmarkId, userId, issue, description) VALUES('2', '1', 'report', 'nothing');"
        db.execute "INSERT INTO bookmark_reports(bookmarkId, userId, issue, description) VALUES('3', '1', 'test', 'test');"
        
    end
    
    #Gets all the bookmark reports from the database
    #Should return true if the length is 4
    def test_get_all_bookmark_reports

        reports = BookmarkReport.getAll()

        assert_equal 4, reports.length
        
    end

    #Gets the first bookmark report from the database: bookmark ID = 1, user ID = 1, issue = something, description = report
    #Should return for all the tests
    def test_get_all_bookmark_reports_details
        
        reports = BookmarkReport.getAll()

        report = reports[0]
        
        assert_equal 1, report.bookmarkId
        assert_equal 1, report.userId
        assert_equal 'something', report.issue
        assert_equal 'report', report.description

    end

    #Adds a report into the database, one that respects the field requiremenets and one that does not
    #Should return true for the first report because it respects the requiremenets and false for the second one
    def test_new_report

        testOne = BookmarkReport.newReport(2, 1, "issue", "description");

        assert_equal true, testOne

        testTwo = BookmarkReport.newReport(nil, 1, " ", "test");

        assert_equal false, testTwo

    end

    #Gets a report of a bookmark that has ID = 1 and a bookmark that has ID = 0
    #Should return true for all the tests made for ID = 1 and ID = 0, because there does not exist a bookmark with ID = 0
    def test_get_by_bookmark_id

        validId = BookmarkReport.getById(1)

        assert_equal 1, validId.userId
        assert_equal 'something', validId.issue
        assert_equal 'report', validId.description

        invalidId = BookmarkReport.getById(0)

        assert_nil invalidId

    end
    
    #Gets all the reports from the database and deletes them
    #Should return true as they do not exist anymore
    def test_delete_reports
        
        reports = BookmarkReport.getAll()
        
        for report in reports 
            
            test = BookmarkReport.deleteReport(report.reportId)
            
            assert_equal true, test
            
        end
        
    end

end