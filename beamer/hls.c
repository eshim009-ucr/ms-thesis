void krnl(int *a, int *b, int *c) {
	#pragma HLS INTERFACE m_axi port=a bundle=gmem0
	#pragma HLS INTERFACE m_axi port=b bundle=gmem1
	#pragma HLS INTERFACE m_axi port=c bundle=gmem2
	for (int i = 0; i < DATA_SIZE; i++) {
		#pragma HLS UNROLL factor=NUM_ADDERS
		c[i] = a[i] + b[i];
	}
}
