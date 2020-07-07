class SearchController < ApplicationController
    def search
        if params[:name].present?
            @users = User.where('name LIKE ?', "%#{params[:name]}%")
        else
            @users = User.none
        end
    end
end
