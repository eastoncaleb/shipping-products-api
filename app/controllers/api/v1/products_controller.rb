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
        product_type = ProductType.find_or_create_by(name: product_params[:product_type_name])
        @product = Product.new(product_params.except(:product_type_name))
        @product.product_type = product_type

        if @product.save
          render json: @product, status: :created
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def update
        product_type = ProductType.find_or_create_by(name: product_params[:product_type_name])
        if @product.update(product_params.except(:product_type_name))
          @product.product_type = product_type
          @product.save
          render json: @product
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @product.destroy
        head :no_content
      end

      def match
        length = params[:length].to_i
        width = params[:width].to_i
        height = params[:height].to_i
        weight = params[:weight].to_i

        @product = ProductMatcher.find_best_match(length: length, width: width, height: height, weight: weight)

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
        params.require(:product).permit(:name, :type, :length, :width, :height, :weight, :product_type_name)
      end
    end
  end
end
