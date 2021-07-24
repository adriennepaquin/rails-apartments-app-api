class ApartmentsController < ApplicationController

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        apartment = find_apartment
        render json: apartment
    end

    def create
        apartment = Apartment.create(apartment_params)
        render json: apartment, status: :created
    end

    def update
        apartment = find_apartment
        if apartment
            apartment.update(apartment_params)
            render json: apartment
        else
            not_found
        end
    end

    def destroy
        apartment = find_apartment
        if apartment
            apartment.destroy
            head :no_content
        else 
            not_found
        end
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def find_apartment
        Apartment.find_by(id: params[:id])
    end

    def not_found
        render json: { error: "Apartment not found" }, status: :not_found
    end
end
