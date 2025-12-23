import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditField extends StatelessWidget {
    final TextEditingController controller;
    final String label;
    final String hint;
    final IconData icon;
    final bool isPassword;
    final TextInputType keyboardType;

    final RxBool _isObscured = true.obs;

    EditField({
        super.key,
        required this.controller,
        required this.label,
        required this.hint,
        required this.icon,
        this.isPassword = false,
        this.keyboardType = TextInputType.text,
    });

    @override
    Widget build(BuildContext context) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),

                /*
                    Check
                    - use Obx if isPassword = true
                    - not use Obx if isPassword = false
                 */
                isPassword ? Obx(() => _buildTextField()) : _buildTextField(),
            ],
        );
    }

    Widget _buildTextField() {
        return TextField(
            controller: controller,
            obscureText: isPassword ? _isObscured.value : false,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                prefixIcon: Icon(icon, color: Colors.grey),
                suffixIcon: isPassword ? IconButton(
                    icon: Icon(
                        _isObscured.value ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                    ),
                    onPressed: () {
                        _isObscured.toggle();
                    },
                ) : null,
                filled: true,
                fillColor: Colors.grey[100],
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFFFC107), width: 1.5),
                ),
            ),
        );
    }
}