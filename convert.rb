#!/usr/bin/evn ruby
# commbank_csv_parse to ledger .dat

class Account
  attr_reader :transactions
  
  def initialize(name)
    @name = name
    @transactions = []
  end
  
  def add(*args)
    @transactions << Transaction.new(*args, self)
  end
  
  def to_s
    @name.to_s
  end
  
  def to_dat
    @transactions.join {|t| t.to_s}
  end
end

class Transaction
  def initialize(date, transfer, name, bal, account)
    @date = date
    @transfer = transfer
    @name = name
    @bal = bal
    @account = account
  end
  
  def transfer
    @transfer.gsub(/\+/, '')
  end
  
  def destination
    # Determine where this transaction went to through regex.
    # @name
    "Expenses:Transaction"
  end
  
  def to_s
    "#{@date} #{@name}\n    #{@account.to_s}    $#{transfer}\n    #{destination}\n"
  end
end

require 'csv'

csv = CSV.read(ARGV[0])

account = Account.new("Assets:Bank:CommBank")

csv.shift
csv.each do |row|
  account.add(row[0], row[1], row[2], row[3])
end

File.open("output.dat", 'w') {|f| f.write( account.to_dat)}
