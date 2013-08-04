//
//  Shader.fsh
//  game
//
//  Created by Volodymyr Boichentsov on 22/05/2013.
//  Copyright (c) 2013 Volodymyr Boichentsov. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
