require 'json'
require 'date'

# Read data from JSON and write report to text file
def setup_files
  path = File.join(File.dirname(__FILE__), '../data/products.json')
  file = File.read(path)
  $products_hash = JSON.parse(file)
  $report_file = File.new("report.txt", "w+")
end

# Helper method: make ************ bar
def make_bar(len = 32)
    $report_file.puts '*' * len
end

# Print "Sales Report" in ascii art
def ascii_art_sales_report
  $report_file.puts " ____        _             ____                       _   "
  $report_file.puts "/ ___|  __ _| | ___  ___  |  _ \\ ___ _ __   ___  _ __| |_ "
  $report_file.puts "\\___ \\ / _` | |/ _ \\/ __| | |_) / _ \\ '_ \\ / _ \\| '__| __|"
  $report_file.puts " ___) | (_| | |  __/\\__ \\ |  _ <  __/ |_) | (_) | |  | |_ "
  $report_file.puts "|____/ \\__,_|_|\\___||___/ |_| \\_\\___| .__/ \\___/|_|   \\__|"
  $report_file.puts "                                    |_|                   "
  $report_file.puts
end

# Print today's date
def show_today_date
  today = Date.today.strftime('%A, %B %d, %Y')
  $report_file.puts "Today's Date: #{today}"
  $report_file.puts
end

# Print "Products" in ascii art
def ascii_art_products
  $report_file.puts " ____                _            _        "
  $report_file.puts "|  _ \\ _ __ ___   __| |_   _  ___| |_ ___  "
  $report_file.puts "| |_) | '__/ _ \\ / _' | | | |/ __| __/ __| "
  $report_file.puts "|  __/| | | (_) | (_| | |_| | (__| |_\\__ \\ "
  $report_file.puts "|_|   |_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/ "
  $report_file.puts
end

# Print the name of the toy
def print_toy_name(toy)
  $report_file.puts toy['title']
  make_bar
end

# Print the retail price of the toy

def calc_retail_price(toy)
  retail_sales = toy['full-price'].to_f
end

def print_retail_price(retail_sales)
  $report_file.puts "Retail Price: $#{retail_sales}"
end

# Calculate and print the total number of purchases
def calc_num_purchases(toy)
  toy['purchases'].length
end

def print_num_purchases(num_purchases)
  $report_file.puts "Total Purchase: #{num_purchases}"
end

# Calculate and print the total amount of sales with inject
def calc_total_sales(toy)
  total_sales = toy['purchases'].inject(0) do |sum, purchase|
    sum + purchase['price'].to_f
  end
  total_sales
end

def print_total_sales(total_sales)
  $report_file.puts "Total Sales: $#{total_sales}"
end

# Calculate and print the average price the toy sold for
def calc_avg_price(total_sales, num_purchases)
  total_sales / num_purchases
end

def print_avg_price(avg_sales)
  $report_file.puts "Average Price: $#{avg_sales}"
end

# Calc and print the avg discount (% or $) based off the avg sales price
def calc_avg_discount(retail_price, avg_price)
  avg_discount = (retail_price - avg_price) / retail_price * 100
  avg_discount = avg_discount.round(2)
  avg_discount
end

def print_avg_discount(avg_discount)
  $report_file.puts "Average Discount: #{avg_discount}%"
  make_bar
  $report_file.puts
end

# Print "Brands" in ascii art
def ascii_art_brands
  $report_file.puts " ____                      _      "
  $report_file.puts "| __ ) _ __ __ _ _ __   __| |___  "
  $report_file.puts "|  _ \\| '__/ _` | '_ \\ / _` / __| "
  $report_file.puts "| |_) | | | (_| | | | | (_| \\__ \\ "
  $report_file.puts "|____/|_|  \\__,_|_| |_|\\__,_|___/ "
  $report_file.puts
end

# Generate unique brand array
def brands
  $products_hash['items'].map { |item| item['brand'] }.uniq
end

# Print the name of the brand
def print_brand_name(brand)
  $report_file.puts brand.upcase
  make_bar
end

# Count the number of the brand's toys we stock
def calc_toys_stock(brand)
  total_stock = 0
  $products_hash['items'].each do |toy|
    if toy['brand'] == brand
      total_stock += toy['stock'].to_i
    end
  end
  total_stock
end

# Print the number of the brand's toys we stock
def print_toys_stock(total_stock)
  $report_file.puts "Numbers of Toys in Stock: #{total_stock}"
end

# Calculate the average price of the brand's toys
def calc_total_price_toys(brand)
  total_price = 0
  $products_hash['items'].each do |toy|
    total_price += toy['full-price'].to_f if toy['brand'] == brand
  end
  return total_price
end

def avg_price_toys(total_price, brand)
  cnt_brand = 0
  $products_hash['items'].each { |toy| cnt_brand += 1 if toy['brand'] == brand }
  (total_price / cnt_brand).round(2)
end

# Print the average price of the brand's toys
def print_avg_price_toys(avg_price)
  $report_file.puts "Average Product Price: $#{avg_price}"
end

# Calculate total revenue of all the brand's toy sales combined

def calc_total_revenue(brand)
  total_revenue = 0
  $products_hash['items'].each do |toy|
    if toy['brand'] == brand
      toy['purchases'].each do |purchase|
        total_revenue += purchase['price']
      end
    end
  end
  total_revenue = total_revenue.round(2)
end

# Print the total revenue of all the brand's toy sales combined
def print_total_revenue(total_revenue)
  $report_file.puts "Total Sales: $#{total_revenue}"
  $report_file.puts
end

#######################################################################
#######################################################################

# Generate report for each product
def make_products_section
  ascii_art_products
  $products_hash['items'].each do |toy|
    print_toy_name(toy)
    print_retail_price(calc_retail_price(toy))
    print_num_purchases(calc_num_purchases(toy))
    print_total_sales(calc_total_sales(toy))
    print_avg_price(calc_avg_price(calc_total_sales(toy),
    calc_num_purchases(toy)))
    print_avg_discount(calc_avg_discount(calc_retail_price(toy),
    calc_avg_price(calc_total_sales(toy), calc_num_purchases(toy))))
  end
end

# Generate report for each brand
def make_brands_section
  ascii_art_brands
  brands.each do |brand|
    print_brand_name(brand)
    print_toys_stock(calc_toys_stock(brand))
    print_avg_price_toys(avg_price_toys(calc_total_price_toys(brand), brand))
    print_total_revenue(calc_total_revenue(brand))
  end
end

# Print ascii art and date for the report
def print_heading
  ascii_art_sales_report
  show_today_date
end

# Print products and brands sections for the report
def print_data
  make_products_section
  make_brands_section
end

# Report consists of heading and data
def create_report
  print_heading
  print_data
end

def start
  setup_files # load, read, parse, and create the files
  create_report # create the report!
end

start
