class UsersController < ApplicationController
    def index
        max = params[:max] || 5
        order_by = params[:name] || "id"
        order = params[:order] || :asc
        range_start = ""
        range_end = ""
    
        range_start = params[:start] ? params[:start].to_i : 1
        range_end = params[:end] ? params[:end].to_i : 5
        
        @users =  User.order( order_by.to_sym => order.to_sym)
                      .where( order_by.to_sym => range_start..range_end )
    
        @users.limit( max + 1 )
        next_record = nil
        if @users.count > max
          next_record = @users.last.id
        end
        @users.limit( max )
        
        page = (params[:page] || 1).to_i 
        per_page = 5
        total_pages = (User.count.to_f / per_page).ceil
        @userr = User.paginate(page: page, per_page: per_page)

        render json: { users: @userr, page: page, totalPages: total_pages }
      end
    end