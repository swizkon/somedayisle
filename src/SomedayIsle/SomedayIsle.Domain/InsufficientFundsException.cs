using System;

namespace SomedayIsle.Domain
{
    [Serializable]
    public class InsufficientFundsException : InvalidOperationException
    {
        public InsufficientFundsException(string message) : base(message)
        {
        }
    }
}