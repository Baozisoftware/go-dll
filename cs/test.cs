using System;
using System.Runtime.InteropServices;
using System.Text;

namespace GolangDllTest
{

    //本示例使用32位版本的DLL.
    class Program
    {

        //以下两个结构体来自test.h,注意32位,64位版本的数据长度.
        struct GoString
        {
            public IntPtr p;
            public int n;
        }

        struct GoSlice
        {
            public IntPtr data;
            public int len;
            public int cap;
        }

        //DLL引用声明
        [DllImport("test", CallingConvention = CallingConvention.Cdecl)]
        static extern int Sum(int a, int b);

        [DllImport("test", CallingConvention = CallingConvention.Cdecl)]
        static extern void Hello();

        [DllImport("test", CallingConvention = CallingConvention.Cdecl)]
        static extern GoString GetStr();

        [DllImport("test", CallingConvention = CallingConvention.Cdecl)]
        static extern GoSlice GetBytes();

        static void Main(string[] args)
        {
            Environment.SetEnvironmentVariable("GODEBUG", "cgocheck=0"); //如果DLL有返回数组(切片),这一行是必须的,并且必须在DLL文件加载前设置.

            Hello(); //调用Hello

            Console.WriteLine(Sum(5, 15)); //调用Sum

            GoString str = GetStr(); //调用GetStr
            //以下为GoString转String
            byte[] bytes = new byte[str.n];
            for (int i = 0; i < str.n; i++)
                bytes[i] = Marshal.ReadByte(str.p, i);
            string s = Encoding.UTF8.GetString(bytes);
            Console.WriteLine(s); //输出结果

            GoSlice arr = GetBytes(); //调用GetBytes
            //以下为GoSlice转Array
            bytes = new byte[arr.len];
            for (int i = 0; i < arr.len; i++)
                bytes[i] = Marshal.ReadByte(arr.data, i);
            //Byte[] to String
            s = Encoding.UTF8.GetString(bytes);
            Console.WriteLine(s); //输出结果
        }
    }
}