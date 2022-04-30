using System;

namespace Raylib.Ease
{
	static
	{
		// Linear Easing functions
		public static float LinearNone(float t, float b, float c, float d) { return (c*t/d + b); }
		public static float LinearIn(float t, float b, float c, float d) { return (c*t/d + b); }
		public static float LinearOut(float t, float b, float c, float d) { return (c*t/d + b); }
		public static float LinearInOut(float t,float b, float c, float d) { return (c*t/d + b); }

		// Sine Easing functions
		public static float SineIn(float t, float b, float c, float d) { return (-c*Math.Cos(t/d*(PI/2.0f)) + c + b); }
		public static float SineOut(float t, float b, float c, float d) { return (c*Math.Sin(t/d*(PI/2.0f)) + b); }
		public static float SineInOut(float t, float b, float c, float d) { return (-c/2.0f*(Math.Cos(PI*t/d) - 1.0f) + b); }

		// Circular Easing functions
		public static float CircIn(float _t, float b, float c, float d) { float t = _t; t /= d; return (-c*(Math.Sqrt(1.0f - t*t) - 1.0f) + b); }
		public static float CircOut(float _t, float b, float c, float d) { float t = _t; t = t/d - 1.0f; return (c*Math.Sqrt(1.0f - t*t) + b); }
		public static float CircInOut(float _t, float b, float c, float d)
		{
			float t = _t;
		    if ((t/=d/2.0f) < 1.0f) return (-c/2.0f*(Math.Sqrt(1.0f - t*t) - 1.0f) + b);
		    t -= 2.0f; return (c/2.0f*(Math.Sqrt(1.0f - t*t) + 1.0f) + b);
		}

		// Cubic Easing functions
		public static float CubicIn(float _t, float b, float c, float d) { float t = _t; t /= d; return (c*t*t*t + b); }
		public static float CubicOut(float _t, float b, float c, float d) { float t = _t; t = t/d - 1.0f; return (c*(t*t*t + 1.0f) + b); }
		public static float CubicInOut(float _t, float b, float c, float d)
		{
			float t = _t;
		    if ((t/=d/2.0f) < 1.0f) return (c/2.0f*t*t*t + b);
		    t -= 2.0f; return (c/2.0f*(t*t*t + 2.0f) + b);
		}

		// Quadratic Easing functions
		public static float QuadIn(float _t, float b, float c, float d) { float t = _t; t /= d; return (c*t*t + b); }
		public static float QuadOut(float _t, float b, float c, float d) { float t = _t; t /= d; return (-c*t*(t - 2.0f) + b); }
		public static float QuadInOut(float _t, float b, float c, float d)
		{
			float t = _t;
		    if ((t/=d/2) < 1) return (((c/2)*(t*t)) + b);
		    return (-c/2.0f*(((t - 1.0f)*(t - 3.0f)) - 1.0f) + b);
		}

		// Exponential Easing functions
		public static float ExpoIn(float t, float b, float c, float d) { return (t == 0.0f) ? b : (c*Math.Pow(2.0f, 10.0f*(t/d - 1.0f)) + b); }
		public static float ExpoOut(float t, float b, float c, float d) { return (t == d) ? (b + c) : (c*(-Math.Pow(2.0f, -10.0f*t/d) + 1.0f) + b);    }
		public static float ExpoInOut(float _t, float b, float c, float d)
		{
			float t = _t;
		    if (t == 0.0f) return b;
		    if (t == d) return (b + c);
		    if ((t/=d/2.0f) < 1.0f) return (c/2.0f*Math.Pow(2.0f, 10.0f*(t - 1.0f)) + b);

		    return (c/2.0f*(-Math.Pow(2.0f, -10.0f*(t - 1.0f)) + 2.0f) + b);
		}

		// Back Easing functions
		public static float BackIn(float _t, float b, float c, float d)
		{
			float t = _t;
		    float s = 1.70158f;
		    float postFix = t/=d;
		    return (c*(postFix)*t*((s + 1.0f)*t - s) + b);
		}

		public static float BackOut(float _t, float b, float c, float d)
		{
			float t = _t;
		    float s = 1.70158f;
		    t = t/d - 1.0f;
		    return (c*(t*t*((s + 1.0f)*t + s) + 1.0f) + b);
		}

		public static float BackInOut(float _t, float b, float c, float d)
		{
			float t = _t;
		    float s = 1.70158f;
		    if ((t/=d/2.0f) < 1.0f)
		    {
		        s *= 1.525f;
		        return (c/2.0f*(t*t*((s + 1.0f)*t - s)) + b);
		    }

		    float postFix = t-=2.0f;
		    s *= 1.525f;
		    return (c/2.0f*((postFix)*t*((s + 1.0f)*t + s) + 2.0f) + b);
		}

		// Bounce Easing functions
		public static float BounceOut(float _t, float b, float c, float d)
		{
			float t = _t;
		    if ((t/=d) < (1.0f/2.75f))
		    {
		        return (c*(7.5625f*t*t) + b);
		    }
		    else if (t < (2.0f/2.75f))
		    {
		        float postFix = t-=(1.5f/2.75f);
		        return (c*(7.5625f*(postFix)*t + 0.75f) + b);
		    }
		    else if (t < (2.5/2.75))
		    {
		        float postFix = t-=(2.25f/2.75f);
		        return (c*(7.5625f*(postFix)*t + 0.9375f) + b);
		    }
		    else
		    {
		        float postFix = t-=(2.625f/2.75f);
		        return (c*(7.5625f*(postFix)*t + 0.984375f) + b);
		    }
		}

		public static float BounceIn(float t, float b, float c, float d) { return (c - BounceOut(d - t, 0.0f, c, d) + b); }
		public static float BounceInOut(float t, float b, float c, float d)
		{
		    if (t < d/2.0f) return (BounceIn(t*2.0f, 0.0f, c, d)*0.5f + b);
		    else return (BounceOut(t*2.0f - d, 0.0f, c, d)*0.5f + c*0.5f + b);
		}

		// Elastic Easing functions
		public static float ElasticIn(float _t, float b, float c, float d)
		{
			float t = _t;
		    if (t == 0.0f) return b;
		    if ((t/=d) == 1.0f) return (b + c);

		    float p = d*0.3f;
		    float a = c;
		    float s = p/4.0f;
		    float postFix = a*Math.Pow(2.0f, 10.0f*(t-=1.0f));

		    return (-(postFix*Math.Sin((t*d-s)*(2.0f*PI)/p )) + b);
		}

		public static float ElasticOut(float _t, float b, float c, float d)
		{
			float t = _t;
		    if (t == 0.0f) return b;
		    if ((t/=d) == 1.0f) return (b + c);

		    float p = d*0.3f;
		    float a = c;
		    float s = p/4.0f;

		    return (a*Math.Pow(2.0f,-10.0f*t)*Math.Sin((t*d-s)*(2.0f*PI)/p) + c + b);
		}

		public static float EaseElasticInOut(float _t, float b, float c, float d)
		{
			float t = _t;
		    if (t == 0.0f) return b;
		    if ((t/=d/2.0f) == 2.0f) return (b + c);

		    float p = d*(0.3f*1.5f);
		    float a = c;
		    float s = p/4.0f;

		    if (t < 1.0f)
		    {
		        float postFix = a*Math.Pow(2.0f, 10.0f*(t-=1.0f));
		        return -0.5f*(postFix*Math.Sin((t*d-s)*(2.0f*PI)/p)) + b;
		    }

		    float postFix = a*Math.Pow(2.0f, -10.0f*(t-=1.0f));

		    return (postFix*Math.Sin((t*d-s)*(2.0f*PI)/p)*0.5f + c + b);
		}
	}
}