//
//  GLKMathUtils.m
//  GLKit
//
//  Based directly on GLKMathUtils.h from Apple, Inc.
//

#import <GLKit/GLKMathUtils.h>
#import <GLKit/GLKVector3.h>
#import <GLKit/GLKMatrix4.h>

GLKVector3 GLKMathProject(GLKVector3 object, GLKMatrix4 model, GLKMatrix4 projection, int *viewport) {
    assert(viewport);
    GLKVector3 v = GLKMatrix4MultiplyVector3(GLKMatrix4Multiply(model, projection), object);
    
    float x = viewport[0] + ((viewport[2] * (v.x + 1.0f)) / 2.0f);
    float y = viewport[1] + ((viewport[3] * (v.y + 1.0f)) / 2.0f);
    float z = (v.z + 1.0f) / 2.0f;
    return GLKVector3Make(x, y, z);
}

GLKVector3 GLKMathUnproject(GLKVector3 window, GLKMatrix4 model, GLKMatrix4 projection, int *viewport, bool *success) {
    assert(viewport);
    bool canInvert = false;
    GLKMatrix4 inverted = GLKMatrix4Invert(GLKMatrix4Multiply(projection, model), &canInvert);
    if (success) {
        *success = canInvert;
    }
    
    if (!canInvert) {
        return GLKVector3Make(0.0f, 0.0f, 0.0f);
    }
    
    float x = ((2.0f * window.x - viewport[0]) / viewport[2]) - 1.0f;
    float y = ((2.0f * window.y - viewport[1]) / viewport[3]) - 1.0f;
    float z = (2.0f * window.z) - 1.0f;
    GLKVector4 unproject4 = GLKMatrix4MultiplyVector4(inverted, GLKVector4Make(x, y, z, 1.0f));
    return GLKVector3Make(unproject4.x, unproject4.y, unproject4.z);
}

#ifdef __OBJC__
NSString *NSStringFromGLKMatrix2(GLKMatrix2 matrix) {
    return nil;
}

NSString *NSStringFromGLKMatrix3(GLKMatrix3 matrix) {
    return nil;
}

NSString *NSStringFromGLKMatrix4(GLKMatrix4 matrix) {
    return [NSString stringWithFormat:@"{{%f, %f, %f, %f}, {%f, %f, %f, %f}, {%f, %f, %f, %f}, {%f, %f, %f, %f}}", matrix.m00, matrix.m01, matrix.m02, matrix.m03,
            matrix.m10, matrix.m11, matrix.m12,matrix.m13,
            matrix.m20, matrix.m21, matrix.m22, matrix.m23,
            matrix.m30, matrix.m31, matrix.m32, matrix.m33];
}

NSString* NSStringFromGLKVector2(GLKVector2 vec)
{
    return [NSString stringWithFormat:@"{%f, %f}", vec.x, vec.y];
}

NSString* NSStringFromGLKVector3(GLKVector3 vec)
{
    return [NSString stringWithFormat:@"{%f, %f, %f}", vec.x, vec.y, vec.z];
}

NSString* NSStringFromGLKVector4(GLKVector4 vec)
{
    return [NSString stringWithFormat:@"{%f, %f, %f, %f}", vec.x, vec.y, vec.z, vec.w];
}

NSString *NSStringFromGLKQuaternion(GLKQuaternion quaternion) {
    return nil;
}

#endif // __OBJC__
