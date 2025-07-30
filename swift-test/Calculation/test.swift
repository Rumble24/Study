////
////  test.swift
////  swift-test
////
////  Created by jingwei on 2024/3/20.
////
//
//import Foundation
//
//// 快排 先找到一个 基准数 然后把比他小的放在左面 比他大的放在右面
//func quickSort(_ arr: inout [Int], left: Int, right: Int) {
//    if left > right {
//        return
//    }
//    
//    var l = left
//    var r = right
//    let temp = arr[l]
//    
//    while l < r {
//        while arr[r] >= temp && l < r {
//            r = r - 1
//        }
//        arr[l] = arr[r]
//        while arr[l] <= temp && l < r {
//            l = l + 1
//        }
//        arr[r] = arr[l]
//    }
//    arr[l] = temp
//    
//    //print("l: \(l) r: \(r)  \(arr)")
//    
//    quickSort(&arr, left: left, right: l - 1)
//    quickSort(&arr, left: r + 1, right: right)
//}
//
///// 无序数组的中位数
//func getZhong(_ arr: inout [Int], left: Int, right: Int) -> Int {
//    if left > right {
//        return -1
//    }
//    var l = left
//    var r = right
//    let temp = arr[l]
//    
//    while l < r {
//        while l < r && arr[r] >= temp {
//            r = r - 1
//        }
//        arr[l] = arr[r]
//        while l < r && arr[r] <= temp {
//            l = l + 1
//        }
//        arr[l] = arr[r]
//    }
//    arr[l] = temp
//    
//    
//    if l == Int((arr.count + 1) / 2) {
//        return l
//    }
//    let a = getZhong(&arr, left: left, right: l - 1)
//    if a == Int((arr.count + 1) / 2) {
//        return a
//    }
//    
//    let b = getZhong(&arr, left: r + 1, right: right)
//    if b == Int((arr.count + 1) / 2) {
//        return b
//    }
//    return -1
//}
//
///// 合并有序数组
//func mergeSortArr(a:[Int], b:[Int]) -> [Int] {
//    var result:[Int] = []
//    var indexA = 0
//    var indexB = 0
//    
//    while indexA < a.count && indexB < b.count {
//        if a[indexA] < b[indexB] {
//            result.append(a[indexA])
//            indexA += 1
//        } else {
//            result.append(b[indexB])
//            indexB += 1
//        }
//    }
//    
//    for item in indexA..<a.count {
//        result.append(a[item])
//    }
//    
//    for item in indexB..<b.count {
//        result.append(b[item])
//    }
//    return result
//}
//
///// 二分查找 找到有序数组里面的目标数字
///// [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33, 44, 66, 77, 88, 99]  2
//func binarySearch(_ nums: [Int], _ target: Int) -> Int {
//    var l = 0
//    var r = nums.count - 1
//    
//    while l <= r {
//        let mid = Int((l + r) / 2)
//        if nums[mid] == target {
//            return mid
//        }
//        else if nums[mid] > target {
//            r = mid - 1
//        } else {
//            l = mid + 1
//        }
//    }
//    
//    return -1
//}
