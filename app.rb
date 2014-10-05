require 'sinatra'
require 'prawn'
require 'area'

class DeathCertificateGenerator < Sinatra::Base
  configure :development do
    require 'pry'
  end

  get '/' do
    erb :index
  end

  post '/certificate' do
    content_type 'application/pdf'

    pdf = Prawn::Document.new(page_layout: :landscape)
    pdf.font 'Courier'
    pdf.image "images/Guilloche-Seal.png"
    pdf.float do
      pdf.move_up 100
      pdf.text "State of #{state_mappings[params[:certificate][:place_of_death].to_region(state: true)]}".upcase, align: :center, size: 32
      pdf.text 'State Board of Health'.upcase, align: :center, size: 24
      pdf.text 'Certificate of Death'.upcase, align: :center, size: 24
    end
    pdf.text "1. #{'Place of Death'.upcase}: <u>#{params[:certificate][:place_of_death].to_region}</u>", inline_format: true
    pdf.text "2. #{'Name of Deceased'.upcase}: <u>#{params[:certificate][:name]}</u>", inline_format: true
    pdf.text "3. #{'Sex'.upcase}: <u>#{params[:certificate][:sex]}</u>", inline_format: true
    pdf.text "4. #{'Color or Race'.upcase}: <u>#{params[:certificate][:race]}</u>", inline_format: true
    pdf.text "5. #{'Marital Status'.upcase}: <u>#{params[:certificate][:marital_status]}</u>", inline_format: true
    pdf.text "6. #{'Date of Birth'.upcase}: <u>#{params[:certificate][:date_of_birth]}</u>", inline_format: true
    pdf.text "7. #{'Occupation'.upcase}: <u>#{params[:certificate][:occupation]}</u>", inline_format: true
    pdf.text "8. #{'Birthplace'.upcase}: <u>#{params[:certificate][:birthplace]}</u>", inline_format: true
    pdf.text "9. #{'Date of Death'.upcase}: <u>#{params[:certificate][:date_of_death]}</u>", inline_format: true
    pdf.text "10. #{'Place of Burial'.upcase}: <u>#{params[:certificate][:place_of_burial]}</u>", inline_format: true
    pdf.text "11. #{'Undertaker'.upcase}: <u>#{params[:certificate][:undertaker]}</u>", inline_format: true
    pdf.render
  end

  def state_mappings
    {
     "AL"=>"Alabama",
     "AK"=>"Alaska",
     "AZ"=>"Arizona",
     "AR"=>"Arkansas",
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
