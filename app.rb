require 'sinatra/base'
require 'sinatra/assetpack'
require 'prawn'
require 'area'
require 'sass'

class DeathCertificateGenerator < Sinatra::Base
  register Sinatra::AssetPack
  assets {
    js :app, [
      '/js/*.js'
    ]

    css :application, [
      '/css/*.css'
    ]

    css_compression :sass
  }

  configure :development do
    require 'pry'
  end

  get '/' do
    erb :index
  end

  get '/certificate' do
    redirect '/'
  end

  post '/certificate' do
    content_type 'application/pdf'

    pdf = Prawn::Document.new(page_layout: :landscape)
    pdf.font 'Courier'
    pdf.image "app/images/Guilloche-Seal.png"
    pdf.float do
      pdf.move_up 100
      pdf.text "#{set_state_name(truncate(params[:certificate][:place_of_death]))}".upcase, align: :center, size: 32
      pdf.text 'State Board of Health'.upcase, align: :center, size: 24
      pdf.text 'Certificate of Death'.upcase, align: :center, size: 24
    end
    pdf.font_size 18
    pdf.text_box "File No.\n#{Time.now.to_i}", at: [600, 500]
    # pdf.stroke_axis
    pdf.bounding_box([0, 400], width: 233, height: 50) do
      pdf.text "01. #{'Place of Death'.upcase}:\n<u>#{set_city_name(truncate(params[:certificate][:place_of_death]))}</u>", inline_format: true
      stroke_bounds(pdf)
    end
    pdf.bounding_box([233, 400], width: 233, height: 50) do
      pdf.text "02. #{'Name of Deceased'.upcase}:\n<u>#{truncate(params[:certificate][:name])}</u>", inline_format: true
      stroke_bounds(pdf)
    end
    pdf.bounding_box([466, 400], width: 233, height: 50) do
      pdf.text "03. #{'Sex'.upcase}:\n<u>#{truncate(params[:certificate][:sex])}</u>", inline_format: true
      stroke_bounds(pdf)
    end
    pdf.bounding_box([0, 350], width: 233, height: 50) do
      pdf.text "04. #{'Color or Race'.upcase}:\n<u>#{truncate(params[:certificate][:race])}</u>", inline_format: true
      stroke_bounds(pdf)
    end
    pdf.bounding_box([233, 350], width: 233, height: 50) do
      pdf.text "05. #{'Marital Status'.upcase}:\n<u>#{truncate(params[:certificate][:marital_status])}</u>", inline_format: true
      stroke_bounds(pdf)
    end
    pdf.bounding_box([466, 350], width: 233, height: 50) do
      pdf.text "06. #{'Date of Birth'.upcase}:\n<u>#{truncate(params[:certificate][:date_of_birth])}</u>", inline_format: true
      stroke_bounds(pdf)
    end
    pdf.bounding_box([0, 300], width: 233, height: 50) do
      pdf.text "07. #{'Occupation'.upcase}:\n<u>#{set_optional_field(truncate(params[:certificate][:occupation]))}</u>", inline_format: true
      stroke_bounds(pdf)
    end
    pdf.bounding_box([233, 300], width: 233, height: 50) do
      pdf.text "08. #{'Birthplace'.upcase}:\n<u>#{set_city_name(truncate(params[:certificate][:birthplace]))}</u>", inline_format: true
      stroke_bounds(pdf)
    end
    pdf.bounding_box([466, 300], width: 233, height: 50) do
      pdf.text "09. #{'Date of Death'.upcase}:\n<u>#{truncate(params[:certificate][:date_of_death])}</u>", inline_format: true
      stroke_bounds(pdf)
    end
    pdf.bounding_box([0, 250], width: 233, height: 50) do
      pdf.text "10. #{'Place of Burial'.upcase}:\n<u>#{set_optional_field(truncate(params[:certificate][:place_of_burial]))}</u>", inline_format: true
      stroke_bounds(pdf)
    end
    pdf.bounding_box([233, 250], width: 233, height: 50) do
      pdf.text "11. #{'Undertaker'.upcase}:\n<u>#{set_optional_field(truncate(params[:certificate][:undertaker]))}</u>", inline_format: true
      stroke_bounds(pdf)
    end
    pdf.image "app/images/stock-photo-approved-stamp.png", at: [500, 200]
    pdf.render
  end

  def stroke_bounds(pdf)
    pdf.transparent(0.5) { pdf.stroke_bounds }
  end

  def set_state_name(input)
    begin
      "State of #{state_mappings[input.to_region(state: true)]}"
    rescue
      "Office of #{input}"
    end
  end

  def set_city_name(input)
    begin
      input.to_region
    rescue
      input
    end
  end

  def set_optional_field(input)
    input.empty? ? 'Unknown' : input
  end

  def truncate(text)
    if text.length > 20
      "#{text[0..17]}..."
    else
      text
    end
  end

  def state_mappings
    {
     "AL"=>"Alabama",
     "AK"=>"Alaska",
     "AZ"=>"Arizona",
     "AR"=>"Arkansas",
     "BD"=>"Bangladesh",
     "CA"=>"California",
     "CO"=>"Colorado",
     "CT"=>"Connecticut",
     "DE"=>"Delaware",
     "FL"=>"Florida",
     "GA"=>"Georgia",
     "HI"=>"Hawaii",
     "ID"=>"Idaho",
     "IL"=>"Illinois",
     "IN"=>"Indiana",
     "IA"=>"Iowa",
     "KS"=>"Kansas",
     "KY"=>"Kentucky",
     "LA"=>"Louisiana",
     "ME"=>"Maine",
     "MD"=>"Maryland",
     "MA"=>"Massachusetts",
     "MI"=>"Michigan",
     "MN"=>"Minnesota",
     "MS"=>"Mississippi",
     "MO"=>"Missouri",
     "MT"=>"Montana",
     "NE"=>"Nebraska",
     "NV"=>"Nevada",
     "NH"=>"New Hampshire",
     "NJ"=>"New Jersey",
     "NM"=>"New Mexico",
     "NY"=>"New York",
     "NC"=>"North Carolina",
     "ND"=>"North Dakota",
     "OH"=>"Ohio",
     "OK"=>"Oklahoma",
     "OR"=>"Oregon",
     "PA"=>"Pennsylvania",
     "RI"=>"Rhode Island",
     "SC"=>"South Carolina",
     "SD"=>"South Dakota",
     "TN"=>"Tennessee",
     "TX"=>"Texas",
     "UT"=>"Utah",
     "VT"=>"Vermont",
     "VA"=>"Virginia",
     "WA"=>"Washington",
     "WV"=>"West Virginia",
     "WI"=>"Wisconsin",
     "WY"=>"Wyoming"
    }
  end
end
