class TenantsController < ApplicationController
    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        tenant = find_tenant
        render json: tenant
    end

    def create
        tenant = Tenant.create(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = find_tenant
        if tenant
            tenant.update(tenant_params)
            render json: tenant
        else
            not_found
        end
    end

    def destroy
        tenant = find_tenant
        if tenant
            tenant.destroy
            head :no_content
        else 
            not_found
        end
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def find_tenant
        Tenant.find_by(id: params[:id])
    end

    def not_found
        render json: { error: "Tenant not found" }, status: :not_found
    end
end
