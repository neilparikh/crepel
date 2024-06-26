# typed: true

def compile_and_run(user_source, functions)
  main_source = <<EOF
  #include <iostream>
  using namespace std;
EOF

  main_source2 = <<EOF
  int main() {
EOF
  source_file = open("source.cpp", "w")
  source = main_source + functions.join("\n") + main_source2 + user_source.join("\n") + "return 0;}"
  source_file.puts(source)
  source_file.close
  `g++ source.cpp`
end


user_source = []
functions = []

compile_and_run(user_source, functions)

input = ""
prev_output = ""
types = ["short", "int", "long" "char", "float", "double", "void"]
in_function = false
block_level = 0
old_source = []
while true
  print "crêpel> "
  raw_input = gets
  break if raw_input.nil?
  input = raw_input.strip
  break if input == ","
  
  is_declaration = types.map { |type| input.start_with?(type) }.include?(true)
  is_block = input.end_with?("{")
  is_end_block = input.end_with?("}")

  if block_level == 0 && is_block
    old_source = user_source.dup
  end
  
  if is_declaration && is_block
    in_function = true
    block_level += 1
    functions << input
  elsif in_function
    functions << input
    block_level += 1 if input.end_with?("{")
    block_level -= 1 if input.end_with?("}")
    in_function = false if block_level == 0
  elsif is_end_block
    user_source << input
    block_level -= 1
  elsif is_block
    user_source << input
    block_level += 1
  elsif is_declaration
    user_source << input
  else
    user_source << "cout << (" + input.gsub(";", "") + ") << endl;"
  end
  
  if block_level == 0
    compile_and_run(user_source, functions)
    if $?.exitstatus != 0
      if is_end_block
        user_source = old_source
        old_source = []
      else
        user_source = user_source[0...-1]
      end
      source_file = open("source.cpp", "w")
      source = main_source + functions.join("\n") + main_source2 + user_source.join("\n") + "return 0;}"
      source_file.puts(source)
      source_file.close
    end
    curr_output = `./a.out`
    to_print = curr_output.dup
    for i in [*0..(prev_output.length-1)]
      break if prev_output[i] != curr_output[i]
      to_print[0] = ""
    end
    prev_output = curr_output
    puts to_print if to_print.strip != ""
  end
end
