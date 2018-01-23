require "net/http"
require "uri"
class TestController < ApplicationController
  def index
    api_key = "e4b2ce5aac1d4aeda19605e6dd82c467"
    secret_key = "455c2557de7a55e544363acc417919ae"
    password = "DoyaDoya4141"
    shop_name = "MizukiStore"
    # HTTPS POST
    uri = URI.parse("https://#{params["shop"]}/admin/oauth/access_token")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request["Content-Type"] = "application/json"
    request.body = { client_id: "e4b2ce5aac1d4aeda19605e6dd82c467", client_secret: "455c2557de7a55e544363acc417919ae", code: params["code"] }.to_json
    response = https.request(request)

    body = JSON.parse(response.body)
    session[:shopify_token] = body['access_token']

    ses = ShopifyAPI::Session.new("#{shop_name}.myshopify.com", body['access_token'])
    ShopifyAPI::Base.activate_session(ses)

    # shop_url = "https://#{api_key}:#{password}@#{shop_name}.myshopify.com/admin"
    # ShopifyAPI::Base.site = shop_url

    #shop = ShopifyAPI::Shop.current

    @product = ShopifyAPI::Product.all

    # @shop = Shop.find(session[:current_shop_id])
    # # ついでにsessionにshop urlを入れておく
    # session[:shopify_shop] = @shop.shopify_url
    # current_user.shopify_token = body['access_token']
    # current_user.save!
    #
    # # 連携
    # @shop.mall["shopify"] = "Shopify"
    # @shop.save!
    #
    # flash[:success] = "Shopifyの連携に成功しました。"
    # redirect_back(fallback_location: root_path)
  end

  def test
    api_key = "e4b2ce5aac1d4aeda19605e6dd82c467"
    secret_key = "455c2557de7a55e544363acc417919ae"
    password = "DoyaDoya4141"
    shop_name = "MizukiStore"
    ShopifyAPI::Session.setup(api_key: api_key, secret: secret_key)
    #shop_url = "https://#{api_key}:#{password}@#{shop_name}.myshopify.com/admin"
    #render plain: shop_url
    #ShopifyAPI::Base.site = shop_url

    session = ShopifyAPI::Session.new("#{shop_name}.myshopify.com")
    scope = ["read_products", "read_orders", "write_products", "write_content"]
    scope = ["read_products"]
    permission_url = session.create_permission_url(scope, request.base_url + test_index_path)
    #render plain: permission_url
    redirect_to permission_url
  end

  def hoge
    shop_name = "MizukiStore"
    ses = ShopifyAPI::Session.new("#{shop_name}.myshopify.com", session[:shopify_token])
    ShopifyAPI::Base.activate_session(ses)
    @shop = ShopifyAPI::Shop.current
    @product = ShopifyAPI::Product.all
  end

  def fuga
    shop_name = "MizukiStore"
    ses = ShopifyAPI::Session.new("#{shop_name}.myshopify.com", session[:shopify_token])
    ShopifyAPI::Base.activate_session(ses)
    @shop = ShopifyAPI::Shop.current
    @product = ShopifyAPI::Product.all
  end
end
