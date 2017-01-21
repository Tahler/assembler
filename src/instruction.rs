#[derive(Debug)]
pub enum InstructionType {
    // Load / Store: 0x1N
    Load = 0x11,
    LoadConstant = 0x12,
    Store = 0x13,

    // Arithmetic: 0x2N
    Add = 0x21,
    Subtract = 0x22,
    Multiply = 0x23,
    Divide = 0x24,
    Equal = 0x25,

    // Goto: 0x3N
    Goto = 0x31,
    GotoIf = 0x32,

    // IO: 0x4N
    CharPrint = 0x41,
    CharRead = 0x42,

    Exit = 0xFF,
}

impl InstructionType {
    pub fn decode(instruction: &str) -> Result<InstructionType, String> {
        match instruction {
            "LOAD" => Ok(InstructionType::Load),
            "LOADC" => Ok(InstructionType::LoadConstant),
            "STORE" => Ok(InstructionType::Store),
            "ADD" => Ok(InstructionType::Add),
            "SUB" => Ok(InstructionType::Subtract),
            "MUL" => Ok(InstructionType::Multiply),
            "DIV" => Ok(InstructionType::Divide),
            "EQ" => Ok(InstructionType::Equal),
            "GOTO" => Ok(InstructionType::Goto),
            "GOTOIF" => Ok(InstructionType::GotoIf),
            "CPRINT" => Ok(InstructionType::CharPrint),
            "CREAD" => Ok(InstructionType::CharRead),
            "EXIT" => Ok(InstructionType::Exit),
            _ => Err(format!("{} does not translate to an instruction.", instruction)),
        }
    }
}
