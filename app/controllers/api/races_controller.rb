module Api
    class RacesController < ApplicationController
        protect_from_forgery with: :null_session
        before_action :find_results, only: [:index, :show]

        def index
            if !request.accept || request.accept == "*/*"
                base = "/api/races"
                if params[:offset]
                    base += ", offset=[#{params[:offset]}]"
                end
                if params[:limit]
                    base += ", limit=[#{params[:limit]}]"
                end
                puts "base: #{base}"
                render plain: base
            else
                #real implementation ...
            end
        end
        def show
            if !request.accept || request.accept == "*/*"
                render plain: "/api/races/#{params[:id]}"
            else
                #real implementation ...
            end
        end

        def create
            if !request.accept || request.accept == "*/*"
                if params[:race][:name]
                    render plain: "#{params[:race][:name]}"
                else
                    render plain: :nothing, status: :ok
                end
            else
                #real implementation
            end
        end

        def find_results
            @results
        end
    end
end