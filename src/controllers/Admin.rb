# Admin.rb
# Alex Parr
# 20/05/2020

require 'sinatra'
require 'sinatra/reloader'
require_relative '../models/SignupRequest'
require_relative '../models/User'



# /admin
get '/admin' do
    if session[:admin] then
        erb :"Admin/index"
    else
        redirect :"bookmarks/all"
    end
end

get '/admin/bookmarkReport' do
    if session[:admin] then
        erb :"Admin/bookmarkReport"
    else
        redirect :"bookmarks/all"
    end
end



get '/admin/userApproval' do
    if session[:admin] then
        
        @new_accounts = SignupRequest.getAll()
        @deleted_users = User.getDeletedUsers()
        
        @display_users = []
        
        for i in (0..(@new_accounts.length - 1))
            for j in (0..(@deleted_users.length - 1))
                if @deleted_users[j].userId == @new_accounts[i].userId
                    @display_users.push(@deleted_users[j])
                end
            end
        end
        erb :"Admin/userApproval"  
    else
        redirect :"bookmarks/all"
    end
   
end

get '/admin/userDisable' do
    if session[:admin] then
        erb :"Admin/userDisable"
    else
        redirect :"bookmarks/all"
    end
    
end
 
get '/admin/viewAccount/:userId' do
    @userId = params[:userId]
    @userRequest = SignupRequest.getByUserId(@userId)
    @userDetails = User.getById(@userId)
    
    if session[:admin] then
        puts @userRequest.time
        @requestId = @userRequest.requestId
        @time = @userRequest.time
        @reason = @userRequest.reason
        @username = @userDetails.username
        erb :"Admin/viewAccount"
    else
        redirect :"bookmarks/all"
    end 
    
end
    
get '/admin/approveAccount/:userId' do
    if session[:admin] then    
        User.setDeleteState(params[:userId], 0)
        SignupRequest.deleteById(params[:userId])
    end
    redirect :"bookmarks/all"
    
end
    
get '/admin/declineAccount/:userId' do
    if session[:admin] then    
        SignupRequest.deleteById(params[:userId])
    end
    redirect :"bookmarks/all"
     
end



