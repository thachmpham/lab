// #define DEBUG

#include <linux/module.h>

static int __init hello_init(void)
{
        printk("hello_init\n");
        pr_err("err\n");
        pr_warn("warn\n");
        pr_info("info aaa\n");
        pr_debug("mydebug init\n");
        return 0;
}

static void __exit hello_exit(void)
{
        pr_debug("mydebug exit\n");
        printk("hello_exit\n");
}

module_init(hello_init);
module_exit(hello_exit);

MODULE_LICENSE("GPL");