//
//  GLKMatrix3.c
//  GLKit
//
//  Modified by sakrist
//  Created by Zach Margolis on 10/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#include <GLKit/GLKMatrix3.h>
#include <assert.h>

#include <OpenGLES/ES2/gl.h>

const GLKMatrix3 GLKMatrix3Identity = {
    1.0f, 0.0f, 0.0f,
    0.0f, 1.0f, 0.0f,
    0.0f, 0.0f, 1.0f,
};

GLKMatrix3 GLKMatrix3Invert(GLKMatrix3 matrix, bool *isInvertible) {
    float determinant = (matrix.m00 * (matrix.m11 * matrix.m22 - matrix.m12 * matrix.m21)) + (matrix.m01 * (matrix.m12 * matrix.m20 - matrix.m22 * matrix.m10)) + (matrix.m02 * (matrix.m10 * matrix.m21 - matrix.m11 *matrix.m20));
    bool canInvert = determinant != 0.0f;
    if (isInvertible) {
        *isInvertible = canInvert;
    }
    
    if (!canInvert) {
        return GLKMatrix3Identity;
    }
    
    return GLKMatrix3Scale(GLKMatrix3Transpose(matrix), determinant, determinant, determinant);
}

GLKMatrix3 GLKMatrix3InvertAndTranspose(GLKMatrix3 matrix, bool *isInvertible) {
    return GLKMatrix3Transpose(GLKMatrix3Invert(matrix, isInvertible));
}
