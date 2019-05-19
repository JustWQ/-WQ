float Func2(float arm[2])
{
	float sum = 0;
	for (int i = 0; i<arm.Length; i++)
	{
		sum += arm[i];
	}
	return sum;
}