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
                @race = Race.find(params[:id])
                render json: @race
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
                @race = Race.create(race_params)
                render plain: @race.name.to_s, status: :created
            end
        end

        def update
            race = Race.find(params[:id])
            race.update(race_params)
            render json: race
        end

        def destroy
            race = Race.find(params[:id])
            race.destroy
            render :nothing=>true, :status => :no_content
        end

        def find_results
            @results
        end

        private

        def race_params
            params.require(:race).permit(:name, :date)
        end
    end
end
