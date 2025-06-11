key_name="$1"
gen_key=$(openssl rand -base64 32)
output_file="gen-key.md"
touch "$output_file"

echo "$genkey" | qrencode -o "${key_name}.png"
echo "${key_name}: \`${gen_key}\`" >> "$output_file"
