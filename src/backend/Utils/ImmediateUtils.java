package backend.Utils;


/**
 * arm对立即数有诸多限制，此类用于检测立即数是否符合arm规范
 * 不符合规范需要使用mov指令将立即数移动至寄存器中处理。
 */

public class ImmediateUtils {
    /**
     * 检查立即数是否可以被编码进指令里
     * ARMv7 汇编因为指令长度限制, 并非所有立即数都可以作为 mov/binary 等指令的参数
     */
    public static boolean checkEncodeImm(int imm) {
        int n = imm;
        for (int i = 0; i < 32; i += 2) {
            if ((n & ~0xFF) == 0) {
                return true;
            }
            n = (n << 2) | (n >>> 30);
        }
        return false;
    }

    /**
     * 检查偏移量是否可以被编码到指令里
     * ARMv7 汇编因为指令长度限制, 并非所有立即数都可以作为立即数间接寻址的偏移量, 它必须足够小.
     */
    public static boolean checkOffsetRange(int offset, boolean isFloat) {
        if (isFloat) {
            // 对 f32 的间接寻址的偏移量必须在 [-1020, 1020] 范围内
            return offset >= -1020 && offset <= 1020;
        } else {
            // 对 i32 的间接寻址的偏移量必须在 [-4095, 4095] 范围内
            return offset >= -4095 && offset <= 4095;
        }
    }

    public static boolean isPowerOfTwo(int imm) {
        boolean isPowerOf2 = false;
        int abs = 1;
        abs = (imm < 0) ? (-imm) : imm;
        if ((abs & (abs - 1)) == 0) {
            isPowerOf2 = true;
        }
        return isPowerOf2;
    }
}
