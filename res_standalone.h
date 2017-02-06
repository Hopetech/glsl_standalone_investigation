ir_variable *const r0001 = new(mem_ctx) ir_variable(glsl_type::vec4_type, "gl_Vertex", ir_var_shader_in);
body.emit(r0001);
ir_variable *const r0002 = new(mem_ctx) ir_variable(glsl_type::mat4[8]_type, "gl_TextureMatrixInverseTranspose", ir_var_uniform);
body.emit(r0002);
ir_variable *const r0003 = new(mem_ctx) ir_variable(glsl_type::mat4[8]_type, "gl_TextureMatrixTranspose", ir_var_uniform);
body.emit(r0003);
ir_variable *const r0004 = new(mem_ctx) ir_variable(glsl_type::mat4_type, "gl_ModelViewProjectionMatrixInverseTranspose", ir_var_uniform);
body.emit(r0004);
ir_variable *const r0005 = new(mem_ctx) ir_variable(glsl_type::mat4_type, "gl_ProjectionMatrixInverseTranspose", ir_var_uniform);
body.emit(r0005);
ir_variable *const r0006 = new(mem_ctx) ir_variable(glsl_type::mat4_type, "gl_ModelViewMatrixInverseTranspose", ir_var_uniform);
body.emit(r0006);
ir_variable *const r0007 = new(mem_ctx) ir_variable(glsl_type::mat4_type, "gl_ModelViewProjectionMatrixTranspose", ir_var_uniform);
body.emit(r0007);
ir_variable *const r0008 = new(mem_ctx) ir_variable(glsl_type::mat4_type, "gl_ProjectionMatrixTranspose", ir_var_uniform);
body.emit(r0008);
ir_variable *const r0009 = new(mem_ctx) ir_variable(glsl_type::mat4_type, "gl_ModelViewMatrixTranspose", ir_var_uniform);
body.emit(r0009);
ir_variable *const r000A = new(mem_ctx) ir_variable(glsl_type::mat4_type, "gl_ModelViewProjectionMatrix", ir_var_uniform);
body.emit(r000A);
ir_function_signature *
extractFloat64Frac(void *mem_ctx, builtin_available_predicate avail)
{
   ir_function_signature *const sig =
      new(mem_ctx) ir_function_signature(glsl_type::uvec2_type, avail);
   ir_factory body(&sig->body, mem_ctx);
   sig->is_defined = true;

   exec_list sig_parameters;

   ir_variable *const r000B = new(mem_ctx) ir_variable(glsl_type::uvec2_type, "a", ir_var_function_in);
   sig_parameters.push_tail(r000B);
   ir_variable *const r000C = body.make_temp(glsl_type::uvec2_type, "vec_ctor");
   body.emit(assign(r000C, bit_and(swizzle_x(r000B), body.constant(1048575u)), 0x01));

   body.emit(assign(r000C, swizzle_y(r000B), 0x02));

   body.emit(ret(r000C));

   sig->replace_parameters(&sig_parameters);
   return sig;
}
ir_function_signature *
extractFloat64Exp(void *mem_ctx, builtin_available_predicate avail)
{
   ir_function_signature *const sig =
      new(mem_ctx) ir_function_signature(glsl_type::uint_type, avail);
   ir_factory body(&sig->body, mem_ctx);
   sig->is_defined = true;

   exec_list sig_parameters;

   ir_variable *const r000D = new(mem_ctx) ir_variable(glsl_type::uvec2_type, "a", ir_var_function_in);
   sig_parameters.push_tail(r000D);
   ir_expression *const r000E = rshift(swizzle_x(r000D), body.constant(int(20)));
   ir_expression *const r000F = bit_and(r000E, body.constant(2047u));
   body.emit(ret(r000F));

   sig->replace_parameters(&sig_parameters);
   return sig;
}
ir_function_signature *
extractFloat64Sign(void *mem_ctx, builtin_available_predicate avail)
{
   ir_function_signature *const sig =
      new(mem_ctx) ir_function_signature(glsl_type::uint_type, avail);
   ir_factory body(&sig->body, mem_ctx);
   sig->is_defined = true;

   exec_list sig_parameters;

   ir_variable *const r0010 = new(mem_ctx) ir_variable(glsl_type::uvec2_type, "a", ir_var_function_in);
   sig_parameters.push_tail(r0010);
   ir_expression *const r0011 = rshift(swizzle_x(r0010), body.constant(int(31)));
   body.emit(ret(r0011));

   sig->replace_parameters(&sig_parameters);
   return sig;
}
ir_function_signature *
extractFloat32Frac(void *mem_ctx, builtin_available_predicate avail)
{
   ir_function_signature *const sig =
      new(mem_ctx) ir_function_signature(glsl_type::uint_type, avail);
   ir_factory body(&sig->body, mem_ctx);
   sig->is_defined = true;

   exec_list sig_parameters;

   ir_variable *const r0012 = new(mem_ctx) ir_variable(glsl_type::uint_type, "a", ir_var_function_in);
   sig_parameters.push_tail(r0012);
   ir_expression *const r0013 = bit_and(r0012, body.constant(8388607u));
   body.emit(ret(r0013));

   sig->replace_parameters(&sig_parameters);
   return sig;
}
ir_function_signature *
extractFloat32Exp(void *mem_ctx, builtin_available_predicate avail)
{
   ir_function_signature *const sig =
      new(mem_ctx) ir_function_signature(glsl_type::uint_type, avail);
   ir_factory body(&sig->body, mem_ctx);
   sig->is_defined = true;

   exec_list sig_parameters;

   ir_variable *const r0014 = new(mem_ctx) ir_variable(glsl_type::uint_type, "a", ir_var_function_in);
   sig_parameters.push_tail(r0014);
   ir_expression *const r0015 = rshift(r0014, body.constant(int(23)));
   ir_expression *const r0016 = bit_and(r0015, body.constant(255u));
   body.emit(ret(r0016));

   sig->replace_parameters(&sig_parameters);
   return sig;
}
ir_function_signature *
extractFloat32Sign(void *mem_ctx, builtin_available_predicate avail)
{
   ir_function_signature *const sig =
      new(mem_ctx) ir_function_signature(glsl_type::uint_type, avail);
   ir_factory body(&sig->body, mem_ctx);
   sig->is_defined = true;

   exec_list sig_parameters;

   ir_variable *const r0017 = new(mem_ctx) ir_variable(glsl_type::uint_type, "a", ir_var_function_in);
   sig_parameters.push_tail(r0017);
   ir_expression *const r0018 = rshift(r0017, body.constant(int(31)));
   body.emit(ret(r0018));

   sig->replace_parameters(&sig_parameters);
   return sig;
}
ir_function_signature *
packFloat64(void *mem_ctx, builtin_available_predicate avail)
{
   ir_function_signature *const sig =
      new(mem_ctx) ir_function_signature(glsl_type::uvec2_type, avail);
   ir_factory body(&sig->body, mem_ctx);
   sig->is_defined = true;

   exec_list sig_parameters;

   ir_variable *const r0019 = new(mem_ctx) ir_variable(glsl_type::uint_type, "zSign", ir_var_function_in);
   sig_parameters.push_tail(r0019);
   ir_variable *const r001A = new(mem_ctx) ir_variable(glsl_type::uint_type, "zExp", ir_var_function_in);
   sig_parameters.push_tail(r001A);
   ir_variable *const r001B = new(mem_ctx) ir_variable(glsl_type::uint_type, "zFrac0", ir_var_function_in);
   sig_parameters.push_tail(r001B);
   ir_variable *const r001C = new(mem_ctx) ir_variable(glsl_type::uint_type, "zFrac1", ir_var_function_in);
   sig_parameters.push_tail(r001C);
   ir_variable *const r001D = new(mem_ctx) ir_variable(glsl_type::uvec2_type, "z", ir_var_auto);
   body.emit(r001D);
   ir_expression *const r001E = lshift(r0019, body.constant(int(31)));
   ir_expression *const r001F = lshift(r001A, body.constant(int(20)));
   ir_expression *const r0020 = add(r001E, r001F);
   body.emit(assign(r001D, add(r0020, r001B), 0x01));

   body.emit(assign(r001D, r001C, 0x02));

   body.emit(ret(r001D));

   sig->replace_parameters(&sig_parameters);
   return sig;
}
ir_function_signature *
countLeadingZeros32(void *mem_ctx, builtin_available_predicate avail)
{
   ir_function_signature *const sig =
      new(mem_ctx) ir_function_signature(glsl_type::uint_type, avail);
   ir_factory body(&sig->body, mem_ctx);
   sig->is_defined = true;

   exec_list sig_parameters;

   ir_variable *const r0021 = new(mem_ctx) ir_variable(glsl_type::uint_type, "a", ir_var_function_in);
   sig_parameters.push_tail(r0021);
   ir_variable *const r0022 = new(mem_ctx) ir_variable(glsl_type::uint_type, "shiftCount", ir_var_auto);
   body.emit(r0022);
   ir_variable *const r0023 = body.make_temp(glsl_type::uint[256]_type, "assignment_tmp");
   body.emit(assign(r0023, ir_constant::zero(mem_ctx, glsl_type::uint[256]_type), 0x00));

   body.emit(assign(r0022, body.constant(0u), 0x01));

   /* IF CONDITION */
   ir_expression *const r0025 = less(r0021, body.constant(65536u));
   ir_expression *const r0026 = equal(r0025, body.constant(true));
   ir_if *f0024 = new(mem_ctx) ir_if(operand(r0026).val);
   exec_list *const f0024_parent_instructions = body.instructions;

      /* THEN INSTRUCTIONS */
      body.instructions = &f0024->then_instructions;

      body.emit(assign(r0022, body.constant(16u), 0x01));

      body.emit(assign(r0021, lshift(r0021, body.constant(int(16))), 0x01));


   body.instructions = f0024_parent_instructions;
   body.emit(f0024);

   /* END IF */

   /* IF CONDITION */
   ir_expression *const r0028 = less