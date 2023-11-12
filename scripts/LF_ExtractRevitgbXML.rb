require 'nokogiri' # gem install nokogiri
require 'csv' #gem install csv

xmlfile = File.open("test export4.xml")
doc = Nokogiri::XML(xmlfile)
doc.remove_namespaces!

#use XPath to find all elements
testinfo = doc.xpath('//Space')

#puts testinfo


#check if any elements were found
if testinfo.any?
    #Create an array to store the extracted data
    extracted_data = []

    #Loop through each element and extract the specific values
    testinfo.each do |space|
        space_id = space['id']
        
        name_element = space.at_xpath('Name')
        space_name = name_element ? name_element.text : 'Name not found'

        type_element = space.at_xpath('Description')
        space_type = type_element ? type_element.text : "Description not found"

        #create an array to store the specific values 
        element_data = [space_id, space_name, space_type]

        extracted_data << element_data
    end

    #define the name of the output file
    output_csv_file = 'output2.csv'

    # Write the extracted data to a CSV file
    CSV.open(output_csv_file, 'wb') do |csv|
        #Write the header row
        csv << ['gbXML Space id', 'Analytical Space Name', 'Building Type', 'Notes']

        #Write each element's data
        extracted_data.each do |element_data|
            csv << element_data
        end
    end

    puts "data extracted and saved to #{output_csv_file}"
else
    puts "no elements found"

end