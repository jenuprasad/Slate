//
//  Floats.swift
//  Slate
//
//  Created by John Coates on 5/31/17.
//  Copyright © 2017 John Coates. All rights reserved.
//

import Foundation

extension RuntimeShader {
    class Float4: TypedVariable, ShaderPrimitive {
        static var name: String = "float4"
    }
    class Float2: TypedVariable, ShaderPrimitive {
        static var name: String = "float2"
    }
    class Float: TypedVariable, ShaderPrimitive {
        static var name: String = "float"
    }
}
