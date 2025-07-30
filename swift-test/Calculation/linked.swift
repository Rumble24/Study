////
////  linked.swift
////  swift-test
////
////  Created by jingwei on 2024/3/21.
////
//
//public class ListNode {
//  public var val: Int
//  public var next: ListNode?
//  public init() { self.val = 0; self.next = nil; }
//  public init(_ val: Int) { self.val = val; self.next = nil; }
//  public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
//}
//
//func printListNode(_ head: ListNode?) {
//    var list = head
//    var arr:[Int] = []
//    while list != nil {
//        arr.append(list!.val)
//        list = list?.next
//    }
//    print(arr)
//}
//
//
//// 反转 带头节点
//func reverse(_ head: ListNode?) {
//    if head == nil || head?.next == nil {
//        return
//    }
//    var p = head?.next
//    head?.next = nil
//    while p != nil {
//        let q = p
//        p = q?.next
//        q?.next = head?.next
//        head?.next = q
//    }
//}
//
//// 反转 1 2 3 4
////[1]
////[2, 1]
////[3, 2, 1]
////[4, 3, 2, 1]
//func reverseList(_ node: ListNode?) -> ListNode? {
//    if node == nil || node?.next == nil {
//        return node
//    }
//    var pre:ListNode? = nil
//    var current:ListNode? = node
//    
//    while current != nil {
//        let next = current?.next
//        current?.next = pre
//        pre = current
//        current = next
//        printListNode(pre)
//    }
//    return pre
//}
//
//
//
////// MARK: 合并有序链表
////func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
////    
////}
//
////234.是否是回文链表  
//// 1.反转之后 一一对比 缺点 需要生成新的对象
//// 2.得到数组 对数组 进行对比 缺点 需要生成新的对象
///// 3.找到中间节点  然后将后面的反转 然后一一对比
/////  1 2 1 2 1
/////  1 1 1 1
/////  快慢指针找到 中间节点
//func isPalindromicLink(node: ListNode?) -> Bool {
//    if node == nil {
//        return false
//    }
//    if node?.next == nil {
//        return true
//    }
//    var fast = node
//    var slow = node
//    while fast?.next != nil && fast?.next?.next != nil {
//        slow = slow?.next
//        fast = fast?.next?.next
//    }
//    
//    var left = node
//    var right = node
//    // 第一种  奇数
//    if fast?.next == nil {
//        right = slow?.next
//        slow?.next = nil
//        
//        var temp = node
//        while temp != nil {
//            if temp?.next === slow {
//                temp?.next = nil
//            }
//            temp = temp?.next
//        }
//    } else if fast?.next?.next == nil { // 第二种  偶数
//        right = slow?.next
//        slow?.next = nil
//    }
//    
//    // 翻转 后面的 链表
//    right = reverseList(right)
//    while left != nil {
//        if left?.val != right?.val {
//            return false
//        }
//        left = left?.next
//        right = right?.next
//    }
//    return true
//}
//
////141.环形链表/环形链表2
//
////160.相交链表
