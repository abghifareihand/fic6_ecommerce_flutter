// import 'package:fic6_ecommerce_flutter/common/constants.dart';
// import 'package:fic6_ecommerce_flutter/data/models/detail_product_response_model.dart';
// import 'package:flutter/material.dart';

// class ListProductCartWidget extends StatelessWidget {
//   final Product product;
//   const ListProductCartWidget({
//     super.key,
//     required this.product,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.only(bottom: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.network(
//               /// get image dari index
//               product.attributes.image,
//               height: 120,
//               width: 130,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product.attributes.name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 Text(
//                   formatCurrency(product.attributes.price),
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 4.0,
//                 ),
//                 // Text(
//                 //   product.attributes.description,
//                 //   style: const TextStyle(
//                 //     fontSize: 12,
//                 //   ),
//                 // ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 const Text(
//                   'Tersedia',
//                   style: TextStyle(
//                     color: Colors.green,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8.0,
//                 ),
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {},
//                       child: const Icon(
//                         Icons.remove_circle_outline,
//                         size: 18,
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 5),
//                       child: Text('0'),
//                     ),
//                     InkWell(
//                       onTap: () {},
//                       child: const Icon(
//                         Icons.add_circle_outline,
//                         size: 18,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
