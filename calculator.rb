#calculator.rb

def find(string, val)
  i = 0
  string = string.split("")

  string.each do |char|
    return i if char == val
    i += 1
  end
end

def find_operator(string)
  i = 0
  string = string.split("")

  string.each do |char|
    if char == "+" || char == "-" || char == "*" || char == "/"
      return i
    end
    i += 1
  end
end

def evaluate(string)
  operator_loc = find_operator(string)
  left = string[0..operator_loc-1]
  right = string[operator_loc+1..-1]

  case string[operator_loc]
  when "+"
    return left.to_i + right.to_i
  when "-"
    return left.to_i - right.to_i
  when "*"
    return left.to_i * right.to_i
  when "/"
    return left.to_i / right.to_i
  end
end

def calculate_brackets(string)
  while string.include?("(")
    left_br = find(string, "(")
    right_br = find(string, ")")
    bracketed = string[left_br+1..right_br-1]
    string.slice!(left_br..right_br)
    string.insert(left_br, calculate(bracketed).to_s)
  end

  return string
end

def calculate(string)
  string = calculate_brackets(string)

  operators = ["-", "+", "*", "/", "^"]
  operators.each do |operator|
    while string.include?(operator)
      operator_loc = find(string, operator)
      left = string[0..operator_loc - 1]
      right = string[operator_loc + 1..-1]

      case operator
      when "+"
        return calculate(left) + calculate(right)
      when "-"
        return calculate(left) - calculate(right)
      when "*"
        return calculate(left) * calculate(right)
      when "/"
        return calculate(left) / calculate(right)
      when "^"
        return calculate(left) ** calculate(right)
      end
    end
  end

  return string.to_i
end

def check_brackets(string)
  string = string.split("")
  lefts = 0
  rights = 0

  string.each do |char|
    lefts += 1 if char == "("
    rights += 1 if char == ")"
  end

  raise "Brackets are not balanced!" if lefts != rights
end

expr = gets
begin
  check_brackets(expr)
  puts calculate(expr)
rescue => exception
  puts exception.message
end
