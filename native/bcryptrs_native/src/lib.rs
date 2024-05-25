#[rustler::nif]
pub fn hash_pwd_salt(password: &str, cost: u32) -> Option<String> {
    match bcrypt::hash(password, cost) {
        Ok(term) => Some(term.to_string()),

        Err(_) => None,
    }
}
#[rustler::nif]
pub fn verify_pass(password: &str, hashed: &str) -> Option<bool> {
    match bcrypt::verify(password, hashed) {
        Ok(term) => Some(term),
        Err(_e) => Some(false),
    }
}

rustler::init!("Elixir.Bcryptrs.Native", [hash_pwd_salt, verify_pass]);
