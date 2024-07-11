package utils;

import java.util.ArrayList;

public class HandlePrintf {
    /**
     * 这个方法会将 formString 按照 %d 截断，返回分开的字符串 list，比如
     * "cr%d%dcr%d" :  ["cr", "%d", "%d", "cr", "%d"]
     * "" : []
     * @param formString  格式化字符串
     * @return ans        截断的字符串List
     */
    public static ArrayList<String> handleString(String formString){
        ArrayList<String> ans = new ArrayList<>();
        int cur = 0;
        formString = formString.replace("\\n", "\\0A");
        if (formString.length() > 2){
            formString = formString.substring(1, formString.length() - 1); // 去除两端引号
            while (cur < formString.length()) {
                int index1 = formString.indexOf("%d", cur);
                int index2 = formString.indexOf("%f", cur);
                int index;
                if( index1 == -1 && index2 == -1){
                    index = -1;
                } else if (index1 == -1){
                    index = index2;
                } else if (index2 == -1){
                    index = index1;
                } else {
                    index = Math.min(index1, index2);
                }
                if (index == -1){
                    ans.add(formString.substring(cur));
                    break;
                }else{
                    if (cur != index){
                        ans.add(formString.substring(cur, index));
                    }
                    ans.add(formString.substring(index, index + 2));
                    cur = index + 2;
                }
            }
        }
        return ans;
    }
    public static int StringLength(String s){
        int len = 0;
        String[] split = s.split("\\\\0A");
        for (String s1 : split){
            len += s1.length();
        }
        int cur = 0;
        while (cur < s.length()){
            int index = s.indexOf("\\0A", cur);
            if (index == -1){
                break;
            }else{
                len += 1;
                cur = index + 1;
            }
        }
        return len;
    }
}
