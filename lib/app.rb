require 'json'
require 'date'

def setup_files
  path = File.join(File.dirname(__FILE__), '../data/products.json')
  file = File.read(path)
  $products_hash = JSON.parse(file)
  # $report_file = File.new("report.txt", "w+")
end

def create_report
  print_heading
  print_data
end

def print_heading
end

def print_data
  make_products_section
  make_brands_section
end

def make_products_section

end

def make_brands_section

end

def start
  setup_files # load, read, parse, and create the files
  create_report # create the report!
end

# Calculate the max title length
def find_max_title_length
  setup_files
  titles = $products_hash['items'].map { |toy| toy['title'] }
  titles.max.length
end

# make ******************************** bar
def make_bar
  puts '*' * find_max_title_length
end

# Print "Sales Report" in ascii art

# Print today's date
def show_today_date
  today = Date.today.strftime('%A, %B %d, %Y')
  puts "Today's Date: #{today}"
end

# Print "Products" in ascii art

# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (% or $) based off the average sales price

# Print "Brands" in ascii art

# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined
