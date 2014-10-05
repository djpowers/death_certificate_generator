require 'sinatra'
require 'prawn'

class DeathCertificateGenerator < Sinatra::Base
  configure :development do
    require 'pry'
  end

  get '/' do
    erb :index
  end

  post '/certificate' do
    content_type 'application/pdf'

    pdf = Prawn::Document.new
    pdf.text params[:certificate][:name]
    pdf.render
  end
end
