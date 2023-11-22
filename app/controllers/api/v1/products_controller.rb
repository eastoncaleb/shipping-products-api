module Api
  module V1
    class ProductsController < ApplicationController
      before_action :product, only: [:show, :update, :destroy]

      def index
        @products = Product.all
        render json: @products
      end

      def show
        render json: @product
      end

      def create
        product_type_id = product_params[:product_type_id]

        if product_type_id.present? && !ProductType.exists?(product_type_id)
          return render json: { error: 'Invalid or missing product type' }, status: :unprocessable_entity
        end

        @product = Product.new(product_params)

        if @product.save
          render json: @product, status: :created
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def update
        if product_params[:product_type_id].present?
          product_type = ProductType.find_by(id: product_params[:product_type_id])
          @product.product_type = product_type if product_type
        end

        @product.assign_attributes(product_params.except(:product_type_id))

        if @product.save
          render json: @product
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end


      def destroy
        if @product.destroy
          head :no_content
        else
          render json: { error: 'Product could not be deleted' }, status: :unprocessable_entity
        end
      end

      def match
        required_params = %i[length width height weight]
        missing_params = required_params.select { |param| params[param].blank? }

        unless missing_params.empty?
          error_message = "Missing required parameters: #{missing_params.join(', ')}"
          return render json: { error: error_message }, status: :unprocessable_entity
        end

        @product = ProductMatcher.find_best_match(
          length: params[:length].to_i,
          width: params[:width].to_i,
          height: params[:height].to_i,
          weight: params[:weight].to_i
        )

        if @product
          render json: @product
        else
          render json: { error: 'No matching product found' }, status: :not_found
        end
      end

      private

      def product
        @product ||= Product.find(params[:id])
      rescue Mongoid::Errors::DocumentNotFound
        render json: { error: 'Product not found' }, status: :not_found
      end

      def product_params
        params.permit(:name, :type, :length, :width, :height, :weight, :product_type_id)
      end
    end
  end
end
