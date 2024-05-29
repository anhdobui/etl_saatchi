def remove_duplicates(input_list):
    unique_list = []
    for item in input_list:
        if item not in unique_list:
            unique_list.append(item)
    return unique_list
def generate_combinations(input_list, current_combination='', index=0, symbol=','):
    combinations = []

    if index == len(input_list):
        # Nếu current_combination không rỗng và không phải là một phần tử đơn lẻ, thêm vào danh sách kết quả
        if current_combination and symbol in current_combination and symbol+'id' not in current_combination:
            combinations.append(current_combination)
        return combinations

    # Không bao gồm phần tử tại index hiện tại
    combinations.extend(generate_combinations(input_list, current_combination, index + 1, symbol))

    # Bao gồm phần tử tại index hiện tại
    if current_combination:
        new_combination = current_combination + symbol + input_list[index]
    else:
        new_combination = input_list[index]

    combinations.extend(generate_combinations(input_list, new_combination, index + 1, symbol))

    return combinations
def generate_ChainDimension(dimension,symbol=','):
 result = []
 for dimension_items in dimension:
  result.extend(generate_combinations(input_list=dimension_items,symbol=symbol))
 return result
def generate_SimpleLevelDimension(dimension):
 result = []
 for dimension_items in dimension:
  for dimension_item in dimension_items:
   result.append(dimension_item)
 return remove_duplicates(result)
def generate_FullHierarchyDimension(dimension,symbol=','):
 result = []
 result.extend(generate_SimpleLevelDimension(dimension))
 result.extend(generate_ChainDimension(dimension,symbol=symbol))
 return remove_duplicates(result)
 #------------------------------------------------------------------------- 
 
def combinations_arrays(arrays,symbol=','):
    if len(arrays) == 1:
        return arrays[0]
    
    sub_combinations = combinations_arrays(arrays[1:],symbol)
    result = []
    for item in arrays[0]:
        for sub_comb in sub_combinations:
            if item:
                if sub_comb:
                    result.append(item + symbol + sub_comb)
                else:
                    result.append(item)
            else:
                result.append(sub_comb)
    return result
 #------------------------------------------------------------------------- 
 # xuất file
def exportSQL(arrays,path):
    unique_combinations = list(set(arrays))
    with open(path, "w") as file:
        for item in unique_combinations:
            file.write(str(item) + "\n")
    print("Kết quả đã được ghi vào file:", path)
    print("Độ dài :", len(unique_combinations))
 # -------------------------------------------------------------------------------