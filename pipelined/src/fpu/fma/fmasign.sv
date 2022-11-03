///////////////////////////////////////////
// fmasign.sv
//
// Written:  6/23/2021 me@KatherineParry.com, David_Harris@hmc.edu
// Modified: 
//
// Purpose: FMA Sign Logic
// 
// A component of the Wally configurable RISC-V project.
// 
// Copyright (C) 2021 Harvey Mudd College & Oklahoma State University
//
// MIT LICENSE
// Permission is hereby granted, free of charge, to any person obtaining a copy of this 
// software and associated documentation files (the "Software"), to deal in the Software 
// without restriction, including without limitation the rights to use, copy, modify, merge, 
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons 
// to whom the Software is furnished to do so, subject to the following conditions:
//
//   The above copyright notice and this permission notice shall be included in all copies or 
//   substantial portions of the Software.
//
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
//   INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR 
//   PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS 
//   BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
//   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
//   OR OTHER DEALINGS IN THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////////////////////

`include "wally-config.vh"

module fmasign(    
    input  logic [2:0]  OpCtrl,               // opperation contol
    input  logic        Xs, Ys, Zs,    // sign of the inputs
    output logic        Ps,     // the product's sign - takes opperation into account
    output logic        As,   // aligned addend sign used in fma - takes opperation into account
    output logic        InvA // Effective subtraction: invert addend
);

    // Calculate the product's sign
    //      Negate product's sign if FNMADD or FNMSUB
    
    // flip is negation opperation
    assign Ps = Xs ^ Ys ^ (OpCtrl[1]&~OpCtrl[2]);
    // flip addend sign for subtraction
    assign As = Zs^OpCtrl[0];
   // Effective subtraction when product and addend have opposite signs
    assign InvA = As ^ Ps;
endmodule