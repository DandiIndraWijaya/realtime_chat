// void main() {
//   List<int> list = [7, 2, 1, 8, 6, 3, 5, 4];
//   int high = list.length - 1;
//   int low = 0;
//   List<int> result = quickSort(list, low, high);
//   print(result);
// }

import 'package:realtime_chat/models/chat_message.dart';

// sort chat messages using quicksort algorithm
List<ChatMessage> runQuickSort(List<ChatMessage> chatMessages) {
  List<ChatMessage> sortedChatMessages =
      quickSort(chatMessages, 0, chatMessages.length - 1);
  return sortedChatMessages;
}

List<ChatMessage> quickSort(List<ChatMessage> list, int low, int high) {
  if (low < high) {
    int pi = partition(list, low, high);

    quickSort(list, low, pi - 1);
    quickSort(list, pi + 1, high);
  }
  return list;
}

int partition(List<ChatMessage> list, low, high) {
  // Base check
  if (list.isEmpty) {
    return 0;
  }
  // Take our last element as pivot and counter i one less than low
  var pivot = list[high].timestamp;

  int i = low - 1;
  for (int j = low; j < high; j++) {
    // When j is < than pivot element we increment i and swap arr[i] and arr[j]
    if (list[j].timestamp < pivot) {
      i++;
      swap(list, i, j);
    }
  }
  // Swap the last element and place in front of the i'th element
  swap(list, i + 1, high);
  return i + 1;
}

// Swapping using a temp variable
void swap(List list, int i, int j) {
  ChatMessage temp = list[i];
  list[i] = list[j];
  list[j] = temp;
}
