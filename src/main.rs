use std::{fs, io};
use std::path::Path;

mod instruction;

use instruction::InstructionType;

fn open(file_path: &str) -> fs::File {
    match fs::File::open(&file_path) {
        Ok(file) => file,
        Err(err) => panic!("Failed to open {}: {}", file_path, err),
    }
}

fn open_lines(file_path: &Path) -> io::Result<Vec<String>> {
    use std::fs::File;
    use std::io::{BufRead, BufReader};

    let file = try!(File::open(file_path));
    let buf_reader = BufReader::new(&file);
    buf_reader.lines().collect()
}

fn decode_reg(reg_str: &str) -> u8 {
    assert!(reg_str.len() == 2);
    assert!(reg_str.starts_with("R"));

    let num = reg_str.chars().nth(1).unwrap();
    num.to_string().parse().unwrap()
}

fn decode_literal(literal_str: &str) -> u16 {
    let is_hex = literal_str.starts_with("0x");
    let parse_result = if is_hex {
        u16::from_str_radix(&literal_str[2..], 16)
    } else {
        literal_str.parse()
    };
    parse_result.unwrap()
}

fn u16_bytes(val: u16) -> [u8; 2] {
    [((0xFF00 & val) >> 8) as u8, ((0x00FF & val) >> 0) as u8]
}

fn bytes_for_reg_literal(args: &[&str]) -> [u8; 3] {
    let reg = decode_reg(args[0]);

    let u16_val = decode_literal(args[1]);
    let u16_bytes = u16_bytes(u16_val);

    [reg, u16_bytes[0], u16_bytes[1]]
}

fn bytes_for_literal_reg(args: &[&str]) -> [u8; 3] {
    let u16_val = decode_literal(args[0]);
    let u16_bytes = u16_bytes(u16_val);

    let reg = decode_reg(args[1]);

    [u16_bytes[0], u16_bytes[1], reg]
}

fn bytes_for_literal(args: &[&str]) -> [u8; 3] {
    let u16_val = decode_literal(args[0]);
    let u16_bytes = u16_bytes(u16_val);

    [u16_bytes[0], u16_bytes[1], 0]
}

fn bytes_for_reg_reg_reg(args: &[&str]) -> [u8; 3] {
    [decode_reg(args[0]), decode_reg(args[1]), decode_reg(args[2])]
}

fn bytes_for_no_args() -> [u8; 3] {
    [0; 3]
}

fn clean_tokens<'a>(tokens: Vec<&'a str>) -> Vec<&'a str> {
    let mut clean_tokens: Vec<&str> = Vec::with_capacity(tokens.len());
    // TODO: use map
    for token in tokens {
        let mut clean_token = token;
        // TODO: consider removing R and 0x prefixes
        if token.ends_with(",") {
            clean_token = &token[..token.len() - 1];
        }
        clean_tokens.push(clean_token);
    }
    clean_tokens
}

fn assemble_line(line: &str) -> Result<[u8; 4], String> {
    let tokens: Vec<&str> = line.split_whitespace().collect();
    let tokens = clean_tokens(tokens);

    let instruction = tokens[0];
    let instruction_type: InstructionType = try!(InstructionType::decode(instruction));

    let args = &tokens[1..];
    let arg_bytes: [u8; 3] = match instruction_type {
        InstructionType::Load |
        InstructionType::LoadConstant => bytes_for_reg_literal(args),

        InstructionType::Store | InstructionType::GotoIf => bytes_for_literal_reg(args),

        InstructionType::Add |
        InstructionType::Subtract |
        InstructionType::Multiply |
        InstructionType::Divide |
        InstructionType::Equal => bytes_for_reg_reg_reg(args),

        InstructionType::Goto |
        InstructionType::CharPrint |
        InstructionType::CharRead => bytes_for_literal(args),
        InstructionType::Exit => bytes_for_no_args(),
    };
    let instruction_byte = instruction_type as u8;
    Ok([instruction_byte, arg_bytes[0], arg_bytes[1], arg_bytes[2]])
}

fn assemble_file(src_path: &Path, out_path: &Path) -> io::Result<()> {
    use std::fs;
    use std::io::Write;

    let src_file_lines = open_lines(src_path).unwrap();

    if out_path.exists() {
        fs::remove_file(out_path);
    }
    let mut out_file: fs::File = fs::File::create(out_path).unwrap();

    for line in src_file_lines {
        let translation_result = assemble_line(&line);
        match translation_result {
            Ok(mut instruction_bytes) => {
                out_file.write_all(&instruction_bytes);
            }
            Err(err) => println!("{:?}", err),
        }
    }

    Ok(())
}

fn main() {
    use std::env;

    let args: Vec<String> = env::args().collect();

    let src_path = Path::new(&args[1]);
    let out_path_buf = src_path.with_extension("sno");
    let out_path = out_path_buf.as_path();

    let result = assemble_file(src_path, out_path);
    match result {
        Err(err) => println!("{:?}", err),
        _ => {}
    }
}
