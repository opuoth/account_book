require 'csv'
csv_data = CSV.read('db/categories.csv', headers: true)
csv_data.each do |data|
  Category.create!(name: data[1], budget_type: data[2])
end

csv_data = CSV.read('db/budgets.csv', headers: true)
csv_data.each do |data|
  Budget.create!(budget_type: data[1], price: data[2], date: data[3], memo: data[4], category_id: data[5])
end

11.times do |year|
  12.times do |month|
    Month.create!(year: year+2019,month: month+1)
  end
end
