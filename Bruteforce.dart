List<List<int>> graph = [
  [0, 8, 3, 4, 10],
  [8, 0, 5, 2, 7],
  [3, 5, 0, 1, 6],
  [4, 3, 1, 0, 3],
  [10, 7, 6, 3, 0]
];

List<String> vertices = ['A', 'B', 'C', 'D', 'E'];

int calculateDistance(List<int> path) {
  int distance = 0;
  for (int i = 0; i < path.length - 1; i++) {
    distance += graph[path[i]][path[i + 1]];
  }
  distance += graph[path.last][path.first];
  return distance;
}

List<List<int>> generatePermutations(List<int> elements) {
  if (elements.length == 1) {
    return [elements];
  }

  List<List<int>> permutations = [];
  for (int i = 0; i < elements.length; i++) {
    var sublist = List<int>.from(elements)..removeAt(i);
    var subPermutations = generatePermutations(sublist);
    for (var perm in subPermutations) {
      permutations.add([elements[i]] + perm);
    }
  }
  return permutations;
}

void tspBruteForce() {
  // 1. Start and List of all vertices (nodes)
  print("1. List of all vertices: ${vertices.join(', ')}");
  
  List<int> indices = List.generate(vertices.length, (i) => i);
  print("   Indices of vertices: $indices");

  // Remove the first vertex (A) from the list of indices
  int startVertex = indices.removeAt(0);
  print("   Start vertex: ${vertices[startVertex]}");

  // 2. Generate all permutations starting with A
  print("\n2. Generating all permutations starting with A...");
  var permutations = generatePermutations(indices);
  print("   Total permutations generated: ${permutations.length}");

  List<int>? bestPath;
  int minDistance = double.maxFinite.toInt();

  // 3. Iterate through all permutations
  print("\n3. Iterating through all permutations:");
  for (var path in permutations) {
    // Add the start vertex (A) at the beginning of each path
    path.insert(0, startVertex);
    print("\n   Checking path: ${path.map((i) => vertices[i]).join(' -> ')} -> A");
    
    // 4. Calculate distance for current path
    int distance = calculateDistance(path);
    print("   4. Calculated distance: $distance");
    
    // 5. Compare with previous best distance
    if (bestPath == null) {
      minDistance = distance;
      bestPath = path;
      print("   5. First path checked. Updating best path and distance.");
    } else {
      print("   5. Is current distance ($distance) less than previous best ($minDistance)?");
      if (distance < minDistance) {
        minDistance = distance;
        bestPath = path;
        print("      Yes! Updating best path and distance.");
      } else {
        print("      No, keeping previous best path and distance.");
      }
    }
  }

  // 6. All permutations checked?
  print("\n6. All permutations checked: Yes");

  // 7. Display results
  print("\n7. Displaying results:");
  if (bestPath != null) {
    print('   Best path: ${bestPath.map((i) => vertices[i]).join(' -> ')} -> A');
  }
  print('   Minimum total distance: $minDistance');

  // 8. End
  print("\n8. End of algorithm");
}

void main() {
  tspBruteForce();
}
