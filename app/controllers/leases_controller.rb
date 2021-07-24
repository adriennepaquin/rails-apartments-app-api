class LeasesController < ApplicationController
    def index
        leases = Lease.all
        render json: leases
    end

    def create
        lease = Lease.create(lease_params)
        render json: lease, status: :created
    end

    def destroy
        lease = find_lease
        if lease
            lease.destroy
            head :no_content
        else 
            not_found
        end
    end

    private

    def lease_params
        params.permit(:apartment_id, :tenant_id, :rent)
    end

    def find_lease
        Lease.find_by(id: params[:id])
    end

    def not_found
        render json: { error: "Lease not found" }, status: :not_found
    end
end
