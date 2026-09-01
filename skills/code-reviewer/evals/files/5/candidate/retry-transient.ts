export async function retryTransient<T>(
  operation: () => Promise<T>,
  isTransient: (error: unknown) => boolean,
  maxAttempts = 3,
): Promise<T> {
  let attempt = 0;

  while (true) {
    try {
      return await operation();
    } catch (error) {
      attempt += 1;
      if (attempt >= maxAttempts || !isTransient(error)) {
        throw error;
      }
    }
  }
}
