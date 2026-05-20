import os
from random import randint


def width_expr(v: int, w: int) -> str:
    if v > 0:
        return f"[{v:<{w}} : 0]"
    else:
        return " "*w


def read_nonneg_int_list(filepath):
    numbers = []
    with open(filepath, 'r', encoding='utf-8') as f:
        for lineno, line in enumerate(f, start=1):
            line = line.strip()
            if not line:      # skip the vacant line
                continue
            try:
                num = int(line)
            except ValueError:
                raise ValueError(f"line {lineno} is not an integer: {line}")
            if num < 0:
                raise ValueError(f"line {lineno} is not a non-negative integer: {line}")
            numbers.append(num)
    return numbers


def gen_bitheap_testvectors(number_list: list, test_size: int=1000, col_names: list[str] | None = None) -> None:
    folder = "testvectors"
    os.makedirs(folder, exist_ok=True)
    testvectors = []
    number_of_columns = len(number_list)
    if col_names is None:
        col_names = [f"in_col{col}" for col in range(number_of_columns)]
    for col in range(number_of_columns):
        col_vector = []
        for i in range(test_size):
            col_vector.append(randint(0, 2**number_list[col]-1))
        testvectors.append(col_vector)
        file_path = os.path.join(folder, f"{col_names[col]}.txt")
        with open(file_path, "w", encoding="utf-8") as f:
            for v in col_vector:
                v_str = format(v, 'x')
                f.write(f"{v_str}\n")
    comp_out_list = []
    for i in range(test_size):
        comp_out = 0
        for col in range(number_of_columns):
            comp_out += testvectors[col][i].bit_count() * (2**col)
        comp_out_list.append(comp_out)
    file_path = os.path.join(folder, "comp_out.txt")
    with open(file_path, "w", encoding="utf-8") as f:
        for v in comp_out_list:
            v_str = format(v, 'x')
            f.write(f"{v_str}\n")



def to_twos_complement_hex(x, n_bits):
    if x < 0:
        x = (1 << n_bits) + x
    hex_width = (n_bits + 3) // 4
    return f"{x:0{hex_width}X}"

